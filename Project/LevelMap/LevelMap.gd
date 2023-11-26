extends Node2D

@onready var debugLabel = $Camera2D/ColorRect/Label
@onready var camera = $Camera2D
@onready var player = $Player

func _ready():
	SignalManager.debugLabel.connect(updateDebugLabel)

func _process(delta):
	camera.global_position = player.global_position

func updateDebugLabel(text: String):
	debugLabel.text = text
