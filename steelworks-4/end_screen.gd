extends Control

func _on_ready() -> void:
	if Game.main_key == false:
		get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_again_button_down() -> void:
	reset()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_menu_button_down() -> void:
	reset()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_exit_button_down() -> void:
	get_tree().quit()
	
func reset():
	Game.balloons_finished = false
	Game.hammer_finished = false
	Game.dice_finished = false
	Game.main_key = false
