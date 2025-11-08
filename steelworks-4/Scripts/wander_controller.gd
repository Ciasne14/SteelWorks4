extends Node2D

@onready var start_position = global_position
@onready var target_position = start_position
@onready var timer = $Timer
@export var range = 64

func _ready():
	update_target_position()
	timer.start()

func update_target_position():
	var target_vector = Vector2(randi_range(-range, range), randi_range(-range, range))
	target_position = start_position + target_vector

func _on_timer_timeout():
	start_position = global_position
	update_target_position()
	timer.start(randf_range(1.0, 2.0))

func get_time_left():
	return timer.time_left
