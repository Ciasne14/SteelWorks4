extends CharacterBody2D

const SPEED := 550.0
@onready var shader: Sprite2D = $Shader
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = %Camera2D2
@onready var bubble: Sprite2D = $Bubble
@onready var label: RichTextLabel = $Bubble/RichTextLabel

@export var eye_scene: PackedScene
var is_throwing := false

func _ready() -> void:
	animated_sprite.connect("animation_finished", Callable(self, "_on_animation_finished"))
	if Game.checkpoint_pos != Vector2(-999, -999):
		global_position = Game.checkpoint_pos

func _physics_process(delta: float) -> void:
	var h := Input.get_axis("left", "right")
	var v := Input.get_axis("up", "down")
	
	if is_throwing:
		return

	if h != 0.0:
		velocity.x = h * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if v != 0.0:
		velocity.y = v * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	if animated_sprite:
		if v > 0.0:
			animated_sprite.animation = "down"
		elif v < 0.0:
			animated_sprite.animation = "up"
		elif h != 0.0:
			animated_sprite.animation = "walking"
		else:
			animated_sprite.animation = "default"

		if h > 0.0:
			animated_sprite.flip_h = true
		elif h < 0.0:
			animated_sprite.flip_h = false

	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("throw") and not is_throwing:
		is_throwing = true
		animated_sprite.animation = "throw"
		animated_sprite.play()
		
	if event.is_action_pressed("quit"):
		get_tree().quit()


func _on_animation_finished() -> void:
		is_throwing = false
		throw_eye()
	
func go_blind():
	shader.visible = true
	
func throw_eye():
	var eye = eye_scene.instantiate()
	get_tree().current_scene.add_child(eye)
	eye.global_position = global_position

	# kierunek w stronę kursora
	var target = get_global_mouse_position()
	var direction = (target - global_position).normalized()
	eye.start(direction)

	# kamera śledzi oko
	camera.reparent(eye)
	shader.reparent(eye)
	shader.scale = Vector2 (1.2, 1.2)
	camera.position = Vector2.ZERO
	camera.zoom = Vector2(0.5, 0.5)
	camera.make_current()

	# po chwili wróć do gracza
	await get_tree().create_timer(2.0).timeout
	camera.reparent(self)
	shader.reparent(self)
	shader.scale = Vector2 (0.6, 0.6)
	shader.position = Vector2.ZERO
	camera.position = Vector2.ZERO
	camera.zoom = Vector2(1, 1)
	camera.make_current()
	animated_sprite.play()

func speech(incoming_text):
	bubble.visible = true
	label.text = incoming_text
