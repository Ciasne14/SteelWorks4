extends Node
@onready var game: Node = $Scenes/game
var checkpoint_pos = Vector2(-999, -999)
var previous_checkpoint_node: Node2D = null
var balloons_finished = false
var hammer_finished = false
var dice_finished = false
var main_key = false
const ENEMYAUTO = preload("uid://bk8smn7eq8yrd")

var general_sound = 0
var music_sound = 0
var effect_sound = 0

func games_finished():
	print(balloons_finished, hammer_finished, dice_finished)
	#game.spawn_enemy()
	if balloons_finished and hammer_finished and dice_finished:
		main_key = true
