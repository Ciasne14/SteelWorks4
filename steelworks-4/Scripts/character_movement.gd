extends CharacterBody2D

const SPEED := 200.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var h := Input.get_axis("left", "right")
	var v := Input.get_axis("up", "down")


	if h != 0.0:
		velocity.x = h * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if v != 0.0:
		velocity.y = v * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	if v > 0.0:
		animated_sprite.animation = "down"
	elif v < 0.0:
		animated_sprite.animation = "up"
	elif h != 0.0:
		animated_sprite.animation = "walking"
	else:
		animated_sprite.animation = "default"

	if h > 0.0:
		animated_sprite.flip_h = true
	elif h < 0.0:
		animated_sprite.flip_h = false

	move_and_slide()
