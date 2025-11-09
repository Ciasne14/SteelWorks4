extends CharacterBody2D

@onready var nav2d: NavigationAgent2D = $NavigationAgent2D
@onready var timer: Timer = $Timer
@onready var death_time: Timer = $DeathTime
@onready var cam2d: Camera2D = %Camera2D2

var waypoints: Array[Node2D]
var current_waypoint: int = -1
var speed
enum States { Chase, Idle, Wander }
var State = States.Wander
var player = null

func _on_ready() -> void:
	setup()
	$blop.volume_db = Game.general_sound + Game.effect_sound 
	
func setup() -> void:
	for waypoint in get_tree().get_nodes_in_group("Waypoint"):
		waypoints.append(waypoint as Node2D)
		
	if waypoints.size() < 2:
		queue_free()
	set_next_waypoint()
	
func set_next_waypoint() -> void:
	var valid_indices: Array[int] = []
	for i in waypoints.size():
		if i != current_waypoint:
			valid_indices.append(i)
	
	current_waypoint = valid_indices.pick_random()
	nav2d.target_position = (
		waypoints[current_waypoint].global_position
	)

func _physics_process(_delta: float) -> void:
	match State:
		States.Chase:
			speed = 190
			if player:
				var direction = (player.position - position).normalized()
				velocity = direction * speed
				move_and_slide()

				$AnimatedSprite2D.flip_h = player.position.x > position.x
			else:
				State = States.Idle

		States.Wander:
			speed = 100
			navigate()
			

		States.Idle:
			velocity = Vector2.ZERO

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	State = States.Chase

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	timer.start(5)
	State = States.Idle
	
	
func navigate() -> void:
	if nav2d.is_navigation_finished():
		setup()
		set_next_waypoint()  # przejdź do następnego punktu
		return

	var next_path_position: Vector2 = nav2d.get_next_path_position()
	velocity = global_position.direction_to(next_path_position) * speed
	move_and_slide()


func _on_timer_timeout() -> void:
	State = States.Wander


func _on_area_2d_body_entered(body: Node2D) -> void:

	Engine.time_scale = 0.3
	body.get_node("CollisionShape2D").queue_free()
	body.get_node("AnimatedSprite2D").queue_free()
	cam2d.reparent(self)
	death_time.start()
	cam2d.zoom = Vector2(5, 5)


func _on_death_time_timeout() -> void:
	Engine.time_scale = 1
	cam2d.zoom = Vector2.ZERO
	get_tree().reload_current_scene()
	
