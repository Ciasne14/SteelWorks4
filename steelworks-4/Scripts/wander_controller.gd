extends Node2D

@onready var start_position = global_position
@onready var target_position
@onready var range = 32

func update_target_position():
	var target_vector = Vector2(randi_range(-range, range), randi_range(-range, range))
	target_position = start_position + target_vector


func _on_timer_timeout() -> void:
	update_target_position()
