extends Node2D

@onready var debugLabel = $Camera2D/ColorRect/Label
@onready var camera = $Camera2D
@onready var player = $Player
@onready var sound = $Sound
@onready var gameUi = $CanvasLayer/GameUI

var pickUps: int = 0
var collected: int = 0

func resetPickUps():
	collected = 0
	pickUps = get_tree().get_nodes_in_group("PickUp").size()

func _ready():
	resetPickUps()
	SignalManager.onPickUp.connect(onPickUp)
	SignalManager.debugLabel.connect(updateDebugLabel)

func _process(delta):
	camera.global_position = player.global_position
	gameUi.updatePickUpsCount(collected,pickUps)
	if Input.is_key_pressed(KEY_ESCAPE) == true:
		GameManager.loadLMainScene()

func updateDebugLabel(text: String):
	debugLabel.text = text

func onPickUp():
	SoundManager.playSoundFx(sound,2)
	collected += 1
	if collected == pickUps:
		SignalManager.showExit.emit()
