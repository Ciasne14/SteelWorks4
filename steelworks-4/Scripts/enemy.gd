extends CharacterBody2D

var speed = 150
enum States {Chase, Idle}
var State
var player = null

func _physics_process(delta: float) -> void:
	if State == States.Chase:
		position += (player.position - position)/speed
		
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = 1
		else:
			$AnimatedSprite2D.flip_h = 0
			
	move_and_slide() 
	
	if State == States.Idle:
		$Timer.start()
		 
func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	State = States.Chase


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	State = States.Idle
