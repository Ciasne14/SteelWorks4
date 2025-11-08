extends Node2D

var str_value = 0
func _process(_delta):
	if event is InputEventKey and event.keycode == Key.SPACE:
		str_value = str_value+5
		$ProgressBar.value = str_value
