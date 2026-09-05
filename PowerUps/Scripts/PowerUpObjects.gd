class_name PowerUpObjects
extends Node2D

@export var powerUpFaction: PowerUp.PowerUpFaction
@export var destroyOnEnd: Node2D
var powerUpRef: PowerUp
var ref: Node2D

func ApplyPowerUps(powerUpManager: PowerUpManager):
	for i in powerUpManager.powerUpPassives.size():
		if (powerUpManager.powerUpPassives[i].powerUpFaction == powerUpFaction):
			powerUpManager.powerUpPassives[i].ActivateStatIncrease(self)

func SetRef(externalRef):
	ref = externalRef

func SetBaseStats():
	pass

func IncreaseStats(_damage: float, _size: float, _time: float, _specialObject: String):
	pass

func SpawnSpecialObject(specialObject: String):
	if (specialObject != ""):
		pass

func DeleteSelf():
	if (destroyOnEnd == null):
		queue_free()
	else:
		destroyOnEnd.queue_free()

func Finalize():
	pass

func AlternativeOutcome():
	pass
