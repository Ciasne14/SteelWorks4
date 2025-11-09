extends AudioStreamPlayer
const level_music = preload("res://Scenes/Circus Clown Music - Sound Effect (HD) [S280Pqq3T_w].mp3")



func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
		
	stream = music
	volume_db = Game.general_sound + Game.music_sound
	play()
	
func play_music_level():
	_play_music(level_music)
