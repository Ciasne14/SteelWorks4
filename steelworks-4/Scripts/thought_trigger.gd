extends Area2D
var player = null


func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	body.get_node("RichTextLabel").queue_free()
