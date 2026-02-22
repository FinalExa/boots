class_name PowerUpContact
extends PowerUp

@export var directSpawners1: Array[ObjectSpawner]
@export var directSpawners2: Array[ObjectSpawner]
@export var directSpawners3: Array[ObjectSpawner]
@export var clashSpawners1: Array[ObjectSpawner]
@export var clashSpawners2: Array[ObjectSpawner]
@export var clashSpawners3: Array[ObjectSpawner]

func HitDirect(ref, index: int):
	if (ref is EnemyController):
		if (index == 1): SpawnObjects(ref, directSpawners1)
		else:
			if (index == 2): SpawnObjects(ref, directSpawners2)
			else:
				if (index == 3): SpawnObjects(ref, directSpawners3)

func HitClash(ref, index: int):
	if (ref is EnemyController):
		if (index == 1): SpawnObjects(ref, clashSpawners1)
		else:
			if (index == 2): SpawnObjects(ref, clashSpawners2)
			else:
				if (index == 3): SpawnObjects(ref, clashSpawners3)

func SpawnObjects(ref: EnemyController, spawnerArray: Array[ObjectSpawner]):
	for i in spawnerArray.size():
		SpawnPowerupObject(spawnerArray[i], ref)

func SpawnPowerupObject(spawner: ObjectSpawner, ref):
	var spawnedPowerUpObject: PowerUpObjects = spawner.SpawnObject()
	if (spawnedPowerUpObject != null):
		InitializePowerUpObject(spawnedPowerUpObject)
		spawnedPowerUpObject.SetRef(ref)
