extends Area2D
@onready var minigame = $minigame.scene_file_path

func _on_body_entered(body: Node2D) -> void:
	pass


func _on_mouse_entered() -> void:
	get_tree().change_scene_to_file(minigame)
	print(minigame)
