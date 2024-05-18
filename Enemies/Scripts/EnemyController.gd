class_name EnemyController
extends CharacterBody2D

signal damaged
signal repelled

@export var enemyMovement: EnemyMovement
var repelledTimer: float
var repelledSpeed: float
var repelledDirection: Vector2
var repelledActive: bool

func _physics_process(delta):
	RepelledTimer(delta)
	move_and_slide()

func ReceiveDamage(damage: int, repelDistance: float, repelDirection: Vector2, repelTime: float):
	emit_signal("damaged", damage)
	emit_signal("repelled")
	repelledTimer = repelTime
	repelledDirection = repelDirection
	repelledSpeed = repelDistance / repelTime
	repelledActive = true

func RepelledTimer(delta):
	if (repelledActive):
		if (repelledTimer > 0):
			repelledTimer -= delta
			velocity = repelledSpeed * repelledDirection
		else:
			repelledActive = false
			enemyMovement.movementLocked = false
			enemyMovement.ResetMovementSpeed()
