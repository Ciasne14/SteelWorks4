extends Node2D

@onready var start_position = global_position
@onready var target_position
@onready var range = 32
<<<<<<< Updated upstream
=======
@onready var timer = $Timer

func _ready():
	update_target_position()
	timer.start()
>>>>>>> Stashed changes

func update_target_position():
	var target_vector = Vector2(randi_range(-range, range), randi_range(-range, range))
	target_position = start_position + target_vector

<<<<<<< Updated upstream

func _on_timer_timeout() -> void:
	update_target_position()
=======
func set_timer(duration):
	timer.start(duration)

func _on_timer_timeout() -> void:
	update_target_position()

func get_time_left():
	return timer.time_left
>>>>>>> Stashed changes
