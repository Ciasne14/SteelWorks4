extends Button

@onready var target_scene = "res://Scenes/main_menu.tscn"



func _on_pressed() -> void:
		get_tree().change_scene_to_file(target_scene)
