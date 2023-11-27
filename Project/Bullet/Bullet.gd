extends Area2D

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

func _on_body_entered(body):
	queue_free()
