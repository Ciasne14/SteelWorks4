extends Node2D

@onready var char2d: CharacterBody2D = $CharacterBody2D
@onready var minigame_layer: CanvasLayer = $MinigameLayer


var active_minigame: Node = null

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
	
func start_minigame(scene: PackedScene):
	if active_minigame:
		active_minigame.visible = true
	else:
		active_minigame = scene.instantiate()
		minigame_layer.add_child(active_minigame)

# podłączenie sygnału wyjścia
	if active_minigame.has_signal("finished"):
		active_minigame.connect("finished", Callable(self, "_on_minigame_finished"))

	# zatrzymujemy tylko gracza (świat dalej działa)
	char2d.set_physics_process(false)
	char2d.set_process(false)

func _on_minigame_finished():
	if active_minigame:
		active_minigame.visible = false

	# wznawiamy gracza
	char2d.set_physics_process(true)
	char2d.set_process(true)
