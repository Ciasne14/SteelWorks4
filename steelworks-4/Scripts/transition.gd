extends Area2D

@export var target_scene: PackedScene
@export var exits_game: bool = false
@export var is_minigame: bool = false

func _on_body_entered(body: Node2D) -> void:
	if exits_game:
		get_tree().quit()
	if is_minigame:
		var game_scene = get_tree().current_scene
		game_scene.start_minigame(target_scene)
	else:
		get_tree().change_scene_to_packed(target_scene)
		
		
