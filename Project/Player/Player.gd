extends CharacterBody2D

class_name Player
var moveSpeed: float = 324

func _ready():
	pass 

func _process(delta):
	if Engine.time_scale != 0:
		getInput()
	rotatePlayer()
	move_and_slide()

func getInput():
	var newVelocity = Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		Input.get_action_strength("Down") - Input.get_action_strength("Up")
		)
	velocity = newVelocity.normalized() * moveSpeed

func rotatePlayer():
	if velocity.x !=0 or velocity.y !=0:
		rotation = velocity.angle()
