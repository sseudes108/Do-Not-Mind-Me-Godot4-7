extends Area2D

@onready var collisionShape = $CollisionShape2D

func _ready():
	hide()
	monitoring = false
	SignalManager.showExit.connect(showExit)

func showExit():
	show()
	monitoring = true

func _on_body_entered(body):
	print("Exited")
