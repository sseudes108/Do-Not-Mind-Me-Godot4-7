extends Area2D


func _on_body_entered(body):
	SignalManager.onPickUp.emit()
	queue_free()
