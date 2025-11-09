extends Area2D
var player = null
@export var image: Image

func _on_body_entered(body: Node2D) -> void:
	player = body
	body.photo(image)
	queue_free()
