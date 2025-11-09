extends Node

var checkpoint_pos = Vector2(-999, -999)
var previous_checkpoint_node: Node2D = null
var balloons_finished = false
var hammer_finished = false
var dice_finished = false
var main_key = false

func games_finished():
	print(balloons_finished, hammer_finished, dice_finished)
	if balloons_finished and hammer_finished and dice_finished:
		main_key = true
