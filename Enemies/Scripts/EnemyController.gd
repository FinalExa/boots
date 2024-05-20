class_name EnemyController
extends CharacterBody2D

signal damaged
signal repelled

@export var enemyMovement: EnemyMovement
@export var attackDistance: float
@export var damageImmunityDuration: float
var damageImmunityTimer: float
var repelledTimer: float
var repelledSpeed: float
var repelledDirection: Vector2
var repelledActive: bool
var damageImmunity: bool

func _process(delta):
	ImmunityTimer(delta)

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
	repelledTimer = damageImmunityDuration
	damageImmunity = true

func RepelledTimer(delta):
	if (repelledActive):
		if (repelledTimer > 0):
			repelledTimer -= delta
			velocity = repelledSpeed * repelledDirection
		else:
			repelledActive = false
			enemyMovement.movementLocked = false
			enemyMovement.ResetMovementSpeed()

func ImmunityTimer(delta):
	if (damageImmunity):
		if (repelledTimer>0):
			repelledTimer-=delta
		else:
			damageImmunity = false
