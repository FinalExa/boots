class_name EnemyMovement
extends Node

signal reached_destination

@export var enemyController: EnemyController
@export var navigationAgent: NavigationAgent2D

@export var defaultMovementSpeed: float
@export var distanceTolerance: float
@export var repathTimerDuration: float
var repathTimer: float
var currentMovementSpeed: float
var target: Node2D
var locationTarget: Vector2
var locationTargetEnabled: bool
var movementLocked: bool

func _ready():
	repathTimer = 0
	currentMovementSpeed = defaultMovementSpeed

func _update_navigation_path(end_position):
	navigationAgent.target_position = end_position

func _physics_process(delta):
	if(!movementLocked && (target != null || locationTargetEnabled)):
		Navigation(delta)
		NavigateOnPath()

func NavigateOnPath():
	var movementSpeed = currentMovementSpeed
	var dir = enemyController.global_position.direction_to(navigationAgent.get_next_path_position())
	enemyController.velocity = dir * movementSpeed
	if ((locationTargetEnabled && enemyController.global_position.distance_to(locationTarget) < distanceTolerance)
	|| (target != null && enemyController.global_position.distance_to(target.global_position) < distanceTolerance)):
		currentMovementSpeed = 0
		enemyController.velocity = Vector2.ZERO
		emit_signal("reached_destination")

func SetNewTarget(newTarget):
	target = newTarget
	locationTarget = Vector2.ZERO
	locationTargetEnabled = false
	Repath()

func SetLocationTarget(locTarget: Vector2):
	locationTarget = locTarget
	target = null
	locationTargetEnabled = true
	Repath()

func Navigation(delta):
	if (repathTimer>0):
		repathTimer-=delta
	else:
		Repath()
		repathTimer = repathTimerDuration

func Repath():
	if(target != null):
		_update_navigation_path(target.global_position)
	else:
		if (locationTargetEnabled):
			_update_navigation_path(locationTarget)
		else:
			_update_navigation_path(enemyController.global_position)

func SetMovementSpeed(newMovementSpeed: float):
	currentMovementSpeed = newMovementSpeed

func ResetMovementSpeed():
	currentMovementSpeed = defaultMovementSpeed

func _on_enemy_repelled():
	SetNewTarget(null)
	currentMovementSpeed = 0
	enemyController.velocity = Vector2.ZERO
	movementLocked = true
