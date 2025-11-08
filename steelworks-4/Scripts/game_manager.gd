extends Node


var balloons_finished = false
var hammer_finished = false
var dice_finished = false
var main_key = false

func games_finished():
	if balloons_finished and hammer_finished and dice_finished:
		main_key = true
