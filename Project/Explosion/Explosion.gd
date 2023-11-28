extends AnimatedSprite2D

func _on_animation_finished():
	hide()

func _on_sound_finished():
	queue_free()
