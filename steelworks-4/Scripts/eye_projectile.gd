extends Node2D


var speed := 600.0
var direction := Vector2.ZERO

func start(dir: Vector2) -> void:
	direction = dir
	$AnimatedSprite2D.play("fly")

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	$AnimatedSprite2D.rotation = direction.angle()
