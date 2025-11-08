extends Area2D

@export var target_scene: PackedScene
@export var exits_game: bool = false

func _on_body_entered(body: Node2D) -> void:
	if exits_game:
		get_tree().quit()
	else:
		get_tree().change_scene_to_packed(target_scene)
