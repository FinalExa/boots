class_name PowerUp
extends Node2D

enum PowerUpFaction {
	BOMB
}

enum PowerUpType {
	CONTACT,
	DOWN_SWITCH,
	UP_SWITCH,
	SPEED_CHARGE,
	TRAIL,
	PASSIVE
}

@export var powerUpName: String
@export var powerUpDescription: String
@export var powerUpFaction: PowerUpFaction
@export var powerUpType: PowerUpType
@export var spawners: Array[ObjectSpawner]
@export var secondarySpawners: Array[ObjectSpawner]
@export var tertiarySpawners: Array[ObjectSpawner]
@export var trailInterval: float
@export var speedChargeMaxValue: float
var speedChargeCurrentValue: float

var powerUpManager: PowerUpManager

func Register():
	powerUpManager.AssignPowerUp(self)

func ExecutePowerUpEffect():
	for i in spawners.size():
		spawners[i].call_deferred("SpawnObject")

func SecondaryExecutePowerUpEffect():
	for i in secondarySpawners.size():
		secondarySpawners[i].call_deferred("SpawnObject")

func TertiaryExecutePowerUpEffect():
	for i in tertiarySpawners.size():
		tertiarySpawners[i].call_deferred("SpawnObject")

func ExecutePowerUpEffectWithValue(value):
	speedChargeCurrentValue += value * get_process_delta_time()
	powerUpManager.speedChargeLabel.text = str(int(speedChargeCurrentValue), "/", speedChargeMaxValue)
	if (speedChargeCurrentValue >= speedChargeMaxValue):
		speedChargeCurrentValue -= speedChargeMaxValue
		for i in spawners.size():
			spawners[i].call_deferred("SpawnObject")
