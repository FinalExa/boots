class_name PowerUpObjects
extends Node2D

@export var powerUpFaction: PowerUp.PowerUpFaction
var powerUpRef: PowerUp
var ref: Node2D

func ApplyPowerUps(powerUpManager: PowerUpManager, id: int):
	IncreaseStats(powerUpManager.powerUpPassiveDataBlocks[id])

func SetRef(externalRef):
	ref = externalRef

func IncreaseStats(dataBlock: PowerUpPassiveDataBlock):
	pass

func SpawnSpecialObjects(specialObjects: Array[String]):
	if (specialObjects.size() > 0):
		pass

func DeleteSelf():
	queue_free()

func Finalize():
	pass

func AlternativeOutcome():
	pass
