extends Node2D
var player = null


func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	Game.checkpoint_pos = $Marker2D.global_position
	Game.previous_checkpoint_node = self
	
