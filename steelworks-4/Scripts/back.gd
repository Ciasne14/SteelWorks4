extends Button

@onready var target_scene = "res://Scenes/main_menu.tscn"



func _on_pressed() -> void:
		get_tree().change_scene_to_file(target_scene)


func _on_mainvolume_mouse_exited() -> void:
	Game.general_sound = $"../AnimatedSprite2D/mainvolume".value

func _on_sfxvolume_mouse_exited() -> void:
	Game.effect_sound = $"../AnimatedSprite2D/sfxvolume".value

func _on_musicvolume_mouse_exited() -> void:
	Game.music_sound = $"../AnimatedSprite2D/musicvolume".value
