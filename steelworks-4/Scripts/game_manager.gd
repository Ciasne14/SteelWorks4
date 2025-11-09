extends Node

var checkpoint_pos = Vector2(-999, -999)
var previous_checkpoint_node: Node2D = null
var balloons_finished = true
var hammer_finished = true
var dice_finished = true
var main_key = true

func games_finished():
	print(balloons_finished, hammer_finished, dice_finished)
	if balloons_finished and hammer_finished and dice_finished:
		main_key = true
