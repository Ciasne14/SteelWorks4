extends Node2D

var str_value = 0
@export var exhaustion = 5
@export var strike = 5
var jump_force = 15
var score = 0


@onready var ball : RigidBody2D = $RigidBody2D

func _ready() -> void:
	$AnimatedSprite2D.play()
	$hammer.play()

func _process(_delta):
	if Input.is_action_just_pressed("hammer"):
		str_value = str_value + strike
		$ProgressBar.value = str_value
	if Input.is_action_just_pressed("strike"):
		$AnimationPlayer.play("hammer")
		$hammer/hammerfall.start()
		$Label.text = str(score)
	if $RigidBody2D.linear_velocity.length() > 0:
		$RigidBody2D/PointLight2D.visible = true
	else:
		$RigidBody2D/PointLight2D.visible = false
		
		
func _on_expire_timer_timeout() -> void:
	if(str_value>11):
		str_value =  str_value-exhaustion
	else:
		str_value = 0
	$ProgressBar.value = str_value

func jump_ball():
	# Dodaj impuls do piłki w kierunku Y (w górę)
	ball.apply_central_impulse(Vector2(0,-jump_force*str_value))


func _on_hammerfall_timeout() -> void:
	jump_ball()
	score = score + str_value
	if(score>349):
		print("Wygrana")
	$RigidBody2D/PointLight2D.visible = true
