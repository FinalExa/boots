class_name PowerUpContact
extends PowerUp

@export var directSpawners: Array[ObjectSpawner]
@export var clashSpawners: Array[ObjectSpawner]

func HitDirect(ref):
	if (ref is EnemyController):
		for i in directSpawners.size():
			SpawnPowerupObject(directSpawners[i], ref)

func HitClash(ref):
	if (ref is EnemyController):
		for i in clashSpawners.size():
			SpawnPowerupObject(clashSpawners[i], ref)

func SpawnPowerupObject(spawner: ObjectSpawner, ref):
	var spawnedPowerUpObject: PowerUpObjects = spawner.SpawnObject()
	if (spawnedPowerUpObject != null):
		InitializePowerUpObject(spawnedPowerUpObject)
		spawnedPowerUpObject.SetRef(ref)
