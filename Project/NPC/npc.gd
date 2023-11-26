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
	var string = "FOV:%.0f" % getFovToPlayer()
	SignalManager.debugLabel.emit(string)

func rayCastToPlayer():
	playerDetection.look_at(player.global_position)

func getFovToPlayer() -> float:
	var direction = global_position.direction_to(player.global_position)
	var dotProduct = direction.dot(velocity.normalized())
	return rad_to_deg(acos(dotProduct))

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
