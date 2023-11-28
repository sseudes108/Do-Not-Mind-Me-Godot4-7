extends Control

@onready var scoreLabel = $MarginContainer/HB/ScoreLabel
@onready var exitLabel = $MarginContainer/HB/ExitLabel


func _ready():
	SignalManager.showExit.connect(showExit)

func _process(delta):
	pass

func updatePickUpsCount(actual, total: int):
	scoreLabel.text = "%s / %s" % [actual, total]

func showExit():
	exitLabel.visible = true
