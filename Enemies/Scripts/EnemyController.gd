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
@export var targetPointer: TargetPointer
@export var attackDistance: float
@export var damageImmunityDuration: float
@export var attachedObjects: Node2D

var currentEffectOverTime: EffectOverTime
var playerRef: PlayerCharacter
var damageImmunityTimer: float
var repelledTimer: float
var repelledSpeed: float
var repelledDirection: Vector2
var repelledActive: bool
var damageImmunity: bool
var spawnerRef: ObjectSpawner

func _process(delta):
	ImmunityTimer(delta)

func _physics_process(_delta):
	move_and_slide()

func ReceiveDamage(damage: float, repelDistance: float, repelDirection: Vector2, repelTime: float):
	emit_signal("damaged", damage)
	ForceStopAttack()
	if (repelTime > 0):
		emit_signal("repelled")
		enemyRepelled.SetRepelled(repelDistance, repelDirection, repelTime)
	damageImmunityTimer = damageImmunityDuration
	damageImmunity = true

func ForceStopAttack():
	if (enemyAttack.attackLaunched):
		enemyAttack.ForceStartCooldown()

func ImmunityTimer(delta):
	if (damageImmunity):
		if (damageImmunityTimer>0):
			damageImmunityTimer -= delta
		else:
			damageImmunity = false

func GetRotator():
	return enemyRotator

func SetSpawnerRef(receivedRef: ObjectSpawner):
	spawnerRef = receivedRef

func EnemyDeath():
	if (spawnerRef != null):
		spawnerRef.ReceivedCallFromDeletedSpawnedObject(self)

func SetEffectOverTime(effect: EffectOverTime):
	if (currentEffectOverTime == null):
		effect.ref = self
		currentEffectOverTime = effect
		call_deferred("PlaceEffect", effect)
		effect.Initialize()
		return
	effect.call_deferred("DeleteSelf")

func PlaceEffect(effect: EffectOverTime):
	add_child(effect)
	effect.global_position = self.global_position

func UnsetEffectOverTime():
	if (currentEffectOverTime != null):
		var effect: EffectOverTime = currentEffectOverTime
		currentEffectOverTime = null
		effect.call_deferred("DeleteSelf")
