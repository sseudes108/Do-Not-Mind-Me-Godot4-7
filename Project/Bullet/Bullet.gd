extends Area2D

var explosionScene: PackedScene = preload("res://Project/Explosion/Explosion.tscn")

const SPEED: float = 216

var direction: Vector2 = Vector2.ZERO
var targetPosition: Vector2 = Vector2.ZERO

func _ready():
	look_at(targetPosition)

func _process(delta):
	position += SPEED * delta * direction

func init(target: Vector2, startPosition: Vector2):
	direction = startPosition.direction_to(target)
	targetPosition = target
	global_position = startPosition

func createExplosion():
	var explosion = explosionScene.instantiate()
	explosion.global_position = global_position
	get_tree().root.add_child(explosion)
	queue_free()
	

func _on_body_entered(body):
	createExplosion()
	if body.is_in_group("Player"):
		SignalManager.onDeath.emit()

func _on_life_timer_timeout():
	createExplosion()
