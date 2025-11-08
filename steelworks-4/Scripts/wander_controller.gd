extends Node2D

@onready var start_position = global_position
@onready var target_position = start_position
@onready var timer = $Timer
@export var range = 32

func _ready():
	update_target_position()
	timer.start()

func update_target_position():
	var target_vector = Vector2(randi_range(-range, range), randi_range(-range, range))
	target_position = start_position + target_vector

func _on_timer_timeout():
	update_target_position()

func get_time_left():
	return timer.time_left
