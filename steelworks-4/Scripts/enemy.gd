extends CharacterBody2D

<<<<<<< Updated upstream
var speed = 150
enum States {Chase, Idle}
var State
=======
@onready var wander_controller = $WanderController
var speed = 150
enum States {Chase, Idle, Wander}
var State = States.Idle
>>>>>>> Stashed changes
var player = null

func _physics_process(delta: float) -> void:
	if State == States.Chase:
<<<<<<< Updated upstream
		position += (player.position - position)/speed
=======
		var direction = (player.position - position).normalized()
		velocity = direction * speed
		move_and_slide()
>>>>>>> Stashed changes
		
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = 1
		else:
			$AnimatedSprite2D.flip_h = 0
<<<<<<< Updated upstream
			
	move_and_slide() 
	
	if State == States.Idle:
		$Timer.start()
=======
	
	if State == States.Idle and wander_controller.get_time_left()==0:
		$WanderController/Timer.start()
		
		
	if State == States.Wander:
		var direction = (wander_controller.target_position - position).normalized()
		velocity = direction * speed
		move_and_slide()

		if position.distance_to(wander_controller.target_position) < 4:
			wander_controller.update_target_position()
>>>>>>> Stashed changes
		 
func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	State = States.Chase


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	State = States.Idle
<<<<<<< Updated upstream
=======
	
>>>>>>> Stashed changes
