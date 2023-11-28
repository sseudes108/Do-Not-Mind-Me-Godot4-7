extends Node

const GASPS = [
	preload("res://assets/sounds/gasp1.wav"),
	preload("res://assets/sounds/gasp2.wav"),
	preload("res://assets/sounds/gasp3.wav"),
]

const POWERUPS = [
	preload("res://assets/sounds/Positive Sounds/sfx_sounds_powerup1.wav"),
	preload("res://assets/sounds/Positive Sounds/sfx_sounds_powerup2.wav"),
	preload("res://assets/sounds/Positive Sounds/sfx_sounds_powerup3.wav"),
	preload("res://assets/sounds/Positive Sounds/sfx_sounds_powerup4.wav"),
	preload("res://assets/sounds/Positive Sounds/sfx_sounds_powerup5.wav"),
	preload("res://assets/sounds/Positive Sounds/sfx_sounds_powerup6.wav"),
	preload("res://assets/sounds/Positive Sounds/sfx_sounds_powerup7.wav"),
	preload("res://assets/sounds/Positive Sounds/sfx_sounds_powerup8.wav"),
	preload("res://assets/sounds/Positive Sounds/sfx_sounds_powerup9.wav")
]

const LASER = [
	preload("res://assets/sounds/sfx_wpn_laser2.wav")
]

func getRandomSoundFromList(sound_list):
	return sound_list.pick_random()

func playSoundFx(player: AudioStreamPlayer2D, key: int):
	match key:
		1:
			player.stream = getRandomSoundFromList(GASPS)
		2:
			player.stream = getRandomSoundFromList(POWERUPS)
		3:
			player.stream = getRandomSoundFromList(LASER)
	player.play()
