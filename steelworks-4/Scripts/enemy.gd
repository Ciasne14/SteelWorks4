extends CharacterBody2D

@onready var wander_controller = $WanderController

var speed = 150
enum States { Chase, Idle, Wander }
var State = States.Wander
var player = null

func _physics_process(delta: float) -> void:
	match State:
		States.Chase:
			if player:
				var direction = (player.position - position).normalized()
				velocity = direction * speed
				move_and_slide()

				$AnimatedSprite2D.flip_h = player.position.x < position.x
			else:
				State = States.Idle

		States.Wander:
			var direction = (wander_controller.target_position - position).normalized()
			velocity = direction * (speed * 0.5)
			move_and_slide()

			if position.distance_to(wander_controller.target_position) < 4:
				wander_controller.update_target_position()

		States.Idle:
			velocity = Vector2.ZERO

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	State = States.Chase

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	State = States.Wander
