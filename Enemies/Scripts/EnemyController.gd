class_name EnemyController
extends CharacterBody2D

signal damaged
signal repelled

@export var enemyMovement: EnemyMovement
@export var enemyRepelled: EnemyRepelled
@export var enemyRotator: EnemyRotator
@export var enemyAttack: ExecuteAttack
@export var enemyHealth: EnemyHealth
@export var enemyShielded: EnemyShielded
@export var attackDistance: float
@export var damageImmunityDuration: float

var playerRef: PlayerCharacter
var damageImmunityTimer: float
var repelledTimer: float
var repelledSpeed: float
var repelledDirection: Vector2
var repelledActive: bool
var damageImmunity: bool

func _process(delta):
	ImmunityTimer(delta)

func _physics_process(_delta):
	move_and_slide()

func ReceiveDamage(damage: float, repelDistance: float, repelDirection: Vector2, repelTime: float):
	emit_signal("damaged", damage)
	emit_signal("repelled")
	if (enemyAttack.attackLaunched):
		enemyAttack.ForceStartCooldown()
	enemyRepelled.SetRepelled(repelDistance, repelDirection, repelTime)
	damageImmunityTimer = damageImmunityDuration
	damageImmunity = true

func ImmunityTimer(delta):
	if (damageImmunity):
		if (damageImmunityTimer>0):
			damageImmunityTimer -= delta
		else:
			damageImmunity = false

func GetRotator():
	return enemyRotator
