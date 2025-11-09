extends Node2D

@onready var char2d: CharacterBody2D = $CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CharacterBody2D.go_blind()
	var event = InputEventKey.new()
	event.keycode = KEY_Q
	InputMap.add_action('throw')
	InputMap.action_add_event('throw', event)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
