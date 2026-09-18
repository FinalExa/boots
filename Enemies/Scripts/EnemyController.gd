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

var currentEffectsOverTime: Array[EffectOverTime]
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

func ReceiveDamage(damage: float, repelDistance: float, repelDirection: Vector2, repelTime: float, damageSource: Node):
	emit_signal("damaged", damage, damageSource)
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

func RemoveFromSpawner():
	if (spawnerRef != null):
		spawnerRef.ReceivedCallFromDeletedSpawnedObject(self)

func Death():
	UnsetEffectsOverTime()
	enemyAttack.frameMaster.RemoveAttack(enemyAttack)
	queue_free()

func SetEffectOverTime(effect: EffectOverTime):
	for i in currentEffectsOverTime.size():
		if (currentEffectsOverTime[i].effectName == effect.effectName):
			if (effect.stackable):
				currentEffectsOverTime[i].Stack(effect)
			effect.call_deferred("DeleteSelf")
			return
	AddEffectOverTime(effect)

func AddEffectOverTime(effect: EffectOverTime):
	currentEffectsOverTime.push_back(effect)
	call_deferred("PlaceEffect", effect)
	effect.Initialize(self)

func PlaceEffect(effect: EffectOverTime):
	add_child(effect)
	effect.global_position = self.global_position

func UnsetEffectOverTime(effect: EffectOverTime):
	if (currentEffectsOverTime.has(effect)):
		currentEffectsOverTime.erase(effect)
		effect.call_deferred("DeleteSelf")

func UnsetEffectsOverTime():
	if (currentEffectsOverTime.size() > 0):
		for i in currentEffectsOverTime.size():
			currentEffectsOverTime[i].call_deferred("DeleteSelf")
		currentEffectsOverTime.clear()
