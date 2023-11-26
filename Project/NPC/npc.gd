extends CharacterBody2D

@onready var sprite = $Sprite2D
enum ENEMY_STATE {PATROLLING, CHASING, SEARCHING}
var state: ENEMY_STATE = ENEMY_STATE.PATROLLING

@export var patrolPoints: NodePath
var wayPoints: Array = []
var currentWayPoint : int = 0

@onready var navAgent = $NavAgent
var speed: float = 108

var player: Player
@onready var playerDetection = $PlayerDetection
@onready var rayCast = $PlayerDetection/RayCast2D

const FOV = {
	ENEMY_STATE.PATROLLING: 60.0,
	ENEMY_STATE.CHASING: 120.0,
	ENEMY_STATE.SEARCHING: 100.0,
}

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	createWayPoints()

func _physics_process(delta):
	#if Input.is_action_just_pressed("Target Location") == true:
	#	navAgent.target_position = get_global_mouse_position()
	updateState()
	rayCastToPlayer()
	
	#Sincroniza o mapa que é apenas atualizado no fim de physics_process corrigindo o erro abaixo:
	#NavigationServer map query failed because it was made before first map synchronization
	await get_tree().process_frame
	
	updateNavigation()
	updateDebugLabel()

func updateDebugLabel():
	var string = "FOV:%.0f\n" % getFovToPlayer()
	string += "PlayerDetected: %s\n" % playerDetected()
	string += "PlayerInFov: %s\n" % playerInFov()
	string += "canSeePlayer: %s\n" % canSeePlayer()
	
	SignalManager.debugLabel.emit(string)

#####DETECTION######
func rayCastToPlayer():
	playerDetection.look_at(player.global_position)

func getFovToPlayer() -> float:
	var direction = global_position.direction_to(player.global_position)
	var dotProduct = direction.dot(velocity.normalized())
	if dotProduct >= -1.0 and dotProduct <= 1.0:
		return rad_to_deg(acos(dotProduct))
	else:
		return 0.0

func playerDetected() -> bool:
	var detected = rayCast.get_collider()
	if detected != null:
		return detected.is_in_group("Player")
	return false

func playerInFov() -> bool:
	return getFovToPlayer() < FOV[state]

func canSeePlayer() -> bool:
	return playerInFov() and playerDetected()

#####MOVE POINTS#####
func createWayPoints():
	for point in get_node(patrolPoints).get_children():
		wayPoints.append(point.global_position)

func navigateToNextWayPoint():
	if currentWayPoint >= len(wayPoints):
		currentWayPoint = 0
	navAgent.target_position = wayPoints[currentWayPoint]
	currentWayPoint += 1

func updateNavigation():
	var nextPosition = navAgent.get_next_path_position()
	var inicialVelocity = (nextPosition - global_position).normalized() * speed
	
	sprite.look_at(nextPosition)
	
	navAgent.set_velocity(inicialVelocity)

#####STATES#####
func patrollingState():
	if navAgent.is_navigation_finished() == true:
		navigateToNextWayPoint()

func updateState():
	match state:
		ENEMY_STATE.PATROLLING:
			patrollingState()

func _on_nav_agent_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()
