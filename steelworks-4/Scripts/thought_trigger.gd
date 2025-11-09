extends Area2D
var player = null
@export var text: String

func _on_body_entered(body: Node2D) -> void:
	player = body
	body.speech(text)
	queue_free()
