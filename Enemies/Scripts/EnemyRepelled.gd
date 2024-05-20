class_name EnemyRepelled
extends Node

@export var enemyController: EnemyController
var repelledActive: bool
var repelledTimer: float
var repelledSpeed: float
var repelledDirection: Vector2

func _physics_process(delta):
	RepelledTimer(delta)

func SetRepelled(repelDistance: float, repelDirection: Vector2, repelTime: float):
	repelledTimer = repelTime
	repelledDirection = repelDirection
	repelledSpeed = repelDistance / repelTime
	repelledActive = true

func RepelledTimer(delta):
	if (repelledActive):
		if (repelledTimer > 0):
			repelledTimer -= delta
			enemyController.velocity = repelledSpeed * repelledDirection
		else:
			repelledActive = false
			enemyController.enemyMovement.movementLocked = false
			enemyController.enemyMovement.ResetMovementSpeed()

