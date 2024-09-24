class_name PowerUp
extends Node2D

enum PowerUpFaction {
	BOMB
}

enum PowerUpType {
	CONTACT,
	SHOOT,
	SPEED_CHARGE,
	TRAIL,
	PASSIVE,
	ABILITY1,
	ABILITY2
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
@export var speedChargeMaxStacks: int
@export var shootMaxProjectiles: int
@export var shootProjectileRechargeTime: float
@export var shootObjectPath: String
var speedChargeCurrentValue: float
var speedChargeCurrentStacks: int

var powerUpManager: PowerUpManager

func Register():
	powerUpManager.AssignPowerUp(self)

func UnRegister():
	powerUpManager.RemovePowerUp(self)

func ExecutePowerUpEffect():
	for i in spawners.size():
		CreatePowerUpEffect(spawners[i])

func SecondaryExecutePowerUpEffect():
	for i in secondarySpawners.size():
		CreatePowerUpEffect(spawners[i])

func TertiaryExecutePowerUpEffect():
	for i in tertiarySpawners.size():
		CreatePowerUpEffect(spawners[i])

func ExecutePowerUpEffectWithValue(value):
	if (speedChargeCurrentStacks < speedChargeMaxStacks):
		speedChargeCurrentValue = clamp(speedChargeCurrentValue + value * get_process_delta_time(), 0, speedChargeMaxValue)
		if (speedChargeCurrentValue >= speedChargeMaxValue):
			speedChargeCurrentStacks += 1
			speedChargeCurrentValue -= speedChargeMaxValue
		powerUpManager.speedChargeLabel.text = str(int(speedChargeCurrentValue), "/", speedChargeMaxValue, " Stacks: ", speedChargeCurrentStacks, "/", speedChargeMaxStacks)

func SpeedChargeActivate():
	if (speedChargeCurrentStacks > 0):
		for i in spawners.size():
				CreatePowerUpEffect(spawners[i])
		speedChargeCurrentStacks -= 1

func CreatePowerUpEffect(spawner: ObjectSpawner):
	var spawnedPowerUpObject: PowerUpObjects = spawner.SpawnObject()
	if (spawnedPowerUpObject != null):
		InitializePowerUpObject(spawnedPowerUpObject)

func InitializePowerUpObject(powerUpObject: PowerUpObjects):
	powerUpObject.SetBaseStats()
	powerUpObject.ApplyPowerUps(powerUpManager)
	powerUpObject.Finalize()
