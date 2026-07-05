class_name PowerUp
extends Node2D

enum PowerUpFaction {
	BOMB,
	FIRE
}

@export var powerUpName: String
@export var powerUpDescription: String
@export var powerUpFaction: PowerUpFaction

var playerRef: PlayerCharacter
var powerUpManager: PowerUpManager

func Register(player: PlayerCharacter):
	powerUpManager.AssignPowerUp(self)
	playerRef = player

func UnRegister():
	powerUpManager.RemovePowerUp(self)
	playerRef = null

func InitializePowerUpObject(powerUpObject: PowerUpObjects):
	powerUpObject.SetBaseStats()
	powerUpObject.ApplyPowerUps(powerUpManager)
	powerUpObject.Finalize()
	return powerUpObject

func LaunchSpawners(spawners: Array[ObjectSpawner]):
	for i in spawners.size():
		CreatePowerUpEffect(spawners[i])

func LaunchSpawnersWithRef(spawners: Array[ObjectSpawner], ref):
	for i in spawners.size():
		CreatePowerUpEffectWithRef(spawners[i], ref)

func CreatePowerUpEffect(spawner: ObjectSpawner):
	var spawnedPowerUpObject: PowerUpObjects = spawner.SpawnObject()
	if (spawnedPowerUpObject != null):
		return InitializePowerUpObject(spawnedPowerUpObject)

func CreatePowerUpEffectWithRef(spawner: ObjectSpawner, ref):
	var spawnedPowerUpObject: PowerUpObjects = spawner.SpawnObject()
	if (spawnedPowerUpObject != null):
		InitializePowerUpObject(spawnedPowerUpObject)
		spawnedPowerUpObject.SetRef(ref)
