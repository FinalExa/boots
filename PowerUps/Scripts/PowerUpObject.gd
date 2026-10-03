class_name PowerUpObject
extends Node2D

@export var powerUpFaction: PowerUp.PowerUpFaction
@export var hasEffect: bool
@export var effect: String
@export var effectDamage: float
@export var effectDuration: float
@export var hasSpecialObject: bool
@export var specialObject: String
var powerUpRef: PowerUp
var ref: Node2D

func ApplyPowerUps(powerUpManager: PowerUpManager, id: int):
	IncreaseStats(powerUpManager.powerUpPassiveDataBlocks[id])
	if (hasSpecialObject): call_deferred("SpawnSpecialObject", specialObject)

func SetRef(externalRef):
	ref = externalRef

func IncreaseStats(_dataBlock: PowerUpPassiveDataBlock):
	pass

func SpawnSpecialObjects(specialObjects: Array[String]):
	if (specialObjects.size() > 0):
		for i in specialObjects.size():
			call_deferred("SpawnSpecialObject", specialObjects[i])

func SpawnSpecialObject(specialObject: String):
	var obj_scene = load(specialObject)
	var obj = obj_scene.instantiate()
	self.add_child(obj)
	obj.global_position = self.global_position

func SpawnEffectOverTime(damage: float, duration: float):
	var obj_scene = load(effect)
	var obj: FireDoT = obj_scene.instantiate()
	obj.damage = damage
	obj.duration = duration
	obj.source = powerUpRef
	return obj

func DeleteSelf():
	queue_free()

func Finalize():
	pass

func AlternativeOutcome():
	pass
