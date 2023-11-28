extends Control

func _ready():
	pass

func _process(delta):
	if Input.is_key_pressed(KEY_SPACE) == true:
		GameManager.loadLevelScene()
