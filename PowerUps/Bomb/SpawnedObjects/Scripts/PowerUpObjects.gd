class_name PowerUpObjects
extends Node2D

@export var powerUpFaction: PowerUp.PowerUpFaction

func ApplyPowerUps(powerUpManager: PowerUpManager):
	for i in powerUpManager.powerUpPassives.size():
		if (powerUpManager.powerUpPassives[i].powerUpFaction == powerUpFaction):
			powerUpManager.powerUpPassives[i].ActivateStatIncrease(self)

func SetBaseStats():
	pass

func IncreaseStats(damage: float, size: float, time: float, specialObject: String):
	pass

func SpawnSpecialObject(specialObject: String):
	if (specialObject != ""):
		pass

func Finalize():
	pass
