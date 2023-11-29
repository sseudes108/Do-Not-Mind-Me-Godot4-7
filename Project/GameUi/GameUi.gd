extends Control

@onready var scoreLabel = $MarginContainer/HB/ScoreLabel
@onready var exitLabel = $MarginContainer/HB/ExitLabel
@onready var timeLabel = $MarginContainer/TimeLabel

@onready var gameOver = $GameOver
@onready var gameOverLabel = $GameOver/GameOverLabel


var time: float = 0

func _ready():
	SignalManager.showExit.connect(showExit)
	SignalManager.onExit.connect(onExit)
	SignalManager.onDeath.connect(onDeath)

func _process(delta):
	time += delta
	timeLabel.text = "Time - %.2f" % time

func updatePickUpsCount(actual, total: int):
	scoreLabel.text = "%s / %s" % [actual, total]

func showExit():
	exitLabel.visible = true

func onExit():
	gameOver.visible = true
	set_process(false)
	Engine.time_scale = 0
	var text
	text = "You won! Took %.2f seconds" % time
	text += "Press Esc to Main Scene"
	gameOverLabel.text = text

func onDeath():
	gameOver.visible = true
	set_process(false)
	Engine.time_scale = 0
	var text
	text = "You lost! Took %.2f seconds\n" % time
	text += "Press Esc to Main Scene"
	gameOverLabel.text = text
