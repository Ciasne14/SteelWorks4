extends Node2D

# Wynik na stole (np. 2 kości)
var roll_result := 0

# Wynik gracza
var player_roll := 0

# Punkty gracza
var score := 0

# UI elements
@onready var dice_button := $DicePlayer/DiceButton
@onready var bet_more_button := $DicePlayer/BetHigher
@onready var bet_less_button := $DicePlayer/BetLower
@onready var score_label := $CanvasLayer/ScoreLabel

var less: bool

func _ready():
	$DicePlayer/DiceButton/AnimatedSprite2D.play()
	$DicePlayer/BetLower/AnimatedSprite2D.play()
	$DicePlayer/BetHigher/AnimatedSprite2D.play()
	dice_button.pressed.connect(_on_roll_pressed)
	bet_more_button.pressed.connect(_on_bet_more_pressed)
	bet_less_button.pressed.connect(_on_bet_less_pressed)
	_reset_game()

# Generowanie wyniku na stole
func _roll_table():

	var evil_roll_1 = randi_range(1,6)
	var evil_roll_2 = randi_range(1,6)
	
	$DicePlayer/EvilDie1.texture = load("res://Assets/Dice/dieRed"+str(evil_roll_1)+".png")
	$DicePlayer/EvilDie2.texture = load("res://Assets/Dice/dieRed"+str(evil_roll_2)+".png")
	roll_result = evil_roll_1 + evil_roll_2  # Suma dwóch kości od 2 do 12

# Generowanie wyniku gracza
func _roll_player():
	var player_roll_1 = randi_range(1,6)
	var player_roll_2 = randi_range(1,6)
	
	$DicePlayer/PlayerDie1.texture = load("res://Assets/Dice/dieWhite"+str(player_roll_1)+".png")
	$DicePlayer/PlayerDie2.texture = load("res://Assets/Dice/dieWhite"+str(player_roll_2)+".png")
	player_roll = player_roll_1 + player_roll_2  # Suma dwóch kości od 2 do 12
	
	if(less && player_roll < roll_result):
		$GameResult.text = "Gratuluję! " +str(player_roll)+ " to MNIEJ niż moje " +str(roll_result)
	elif(less && player_roll > roll_result):
		$GameResult.text = "Niestety! " +str(player_roll)+ " to WIĘCEJ niż moje " +str(roll_result)
	elif(!less && player_roll < roll_result):
		$GameResult.text = "Niestety! " +str(player_roll)+ " to MNIEJ niż moje " +str(roll_result)
	elif(!less && player_roll > roll_result):
		$GameResult.text = "Gratuluję! " +str(player_roll)+ " to WIĘCEJ niż moje " +str(roll_result)
	else:
		$GameResult.text = "REMIS GŁUPCZE!"

# Obstawienie "więcej"
func _on_bet_more_pressed():
	less = false
	$AnimationPlayer.play("PlayerCupRoll")
	$PlayerCup/PlayerCupTimer.start()
	$DicePlayer/PlayerDie1.visible = false
	$DicePlayer/PlayerDie2.visible = false

# Obstawienie "mniej"
func _on_bet_less_pressed():
	less = true
	$AnimationPlayer.play("PlayerCupRoll")
	$PlayerCup/PlayerCupTimer.start()
	$DicePlayer/PlayerDie1.visible = false
	$DicePlayer/PlayerDie2.visible = false

# Rzut kośćmi
func _on_roll_pressed():
	$AnimationPlayer.play("EvilCupRoll")
	$DicePlayer/EvilDie1.visible = false
	$DicePlayer/EvilDie2.visible = false
	$Cup/EvilCupTimer.start()
# Zaktualizowanie wyniku

# Restart gry
func _on_restart_pressed():
	_reset_game()

func _reset_game():
	score = 0


func _on_evil_cup_timer_timeout() -> void:
	_roll_table()
	$DicePlayer/EvilDie1.visible = true
	$DicePlayer/EvilDie2.visible = true

func _on_player_cup_timer_timeout() -> void:
	_roll_player()
	$DicePlayer/PlayerDie1.visible = true
	$DicePlayer/PlayerDie2.visible = true
