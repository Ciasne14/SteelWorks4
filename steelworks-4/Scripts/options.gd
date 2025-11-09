extends Node2D
@onready var mainvolume: HSlider = $AnimatedSprite2D/mainvolume
@onready var sfxvolume: HSlider = $AnimatedSprite2D/sfxvolume
@onready var musicvolume: HSlider = $AnimatedSprite2D/musicvolume


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mainvolume.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	sfxvolume.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	musicvolume.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	

func _on_mainvolume_mouse_exited() -> void:
	AudioServer.set_bus_volume_linear(0, linear_to_db(mainvolume.value))
	Game.general_sound = mainvolume.value
	print(Game.general_sound)

func _on_sfxvolume_mouse_exited() -> void:
	AudioServer.set_bus_volume_linear(0, linear_to_db(sfxvolume.value))
	Game.effect_sound = sfxvolume.value


func _on_musicvolume_mouse_exited() -> void:
		AudioServer.set_bus_volume_linear(0, linear_to_db(musicvolume.value))
		Game.music_sound = musicvolume.value
