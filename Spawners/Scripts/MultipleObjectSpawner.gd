class_name MultipleObjectSpawner
extends ObjectSpawner

@export var objectPaths: Array[String]
@export var objectSpawnLocations: Array[Node2D]
@export var aggressiveSpawn: bool
var activeObjects: Array[Node2D]
var mapObjective: MapObjective
var setTarget: bool

func SpawnObjects():
	if (!aggressiveSpawn):
		NormalSpawn()
	else:
		AggressiveSpawn()

func NormalSpawn():
	ClearActiveObjects()
	if (self.is_inside_tree() && objectPaths.size() > 0 && objectPaths.size() == objectSpawnLocations.size()):
		for i in objectPaths.size():
			if (objectPaths[i] != ""):
				var newObj = CreateAndReturnObject(objectPaths[i], objectSpawnLocations[i])
				if (!activeObjects.has(newObj)): activeObjects.push_back(newObj)
				if (setTarget && newObj is EnemyController):
					newObj.targetPointer.Activate()

func AggressiveSpawn():
	if (self.is_inside_tree() && objectPaths.size() > 0 && objectPaths.size() == objectSpawnLocations.size()):
		if (activeObjects.size() != objectPaths.size()):
			NormalSpawn()
			return
		for i in activeObjects.size():
			if (activeObjects[i] == null && objectPaths[i] != ""):
				var newObj = CreateAndReturnObject(objectPaths[i], objectSpawnLocations[i])
				if (!activeObjects.has(newObj)): activeObjects[i] = newObj
				if (setTarget && newObj is EnemyController):
					newObj.targetPointer.Activate()

func ClearActiveObjects():
	if (activeObjects.size() > 0):
		for i in activeObjects.size():
			if (activeObjects[i] != null):
				activeObjects[i].queue_free()
		activeObjects.clear()

func ReceivedCallFromDeletedSpawnedObject(object):
	if (object is EnemyController):
		mapObjective.OnSpawnedEnemyDeath()
	if (!aggressiveSpawn):
		if (activeObjects.has(object)):
			if (object is EnemyController): mapObjective.RequestEnemyData(object)
			activeObjects.erase(object)
			if (activeObjects.size() == 0 && mapObjective != null):
				if (mapObjective is DefeatWavesObjective):
					mapObjective.SpawnAndAdvanceWave()
	else:
		for i in activeObjects.size():
			if (activeObjects[i] == object):
				activeObjects[i] = null
				break

func ReturnCount():
	if (objectPaths.size() > 0 && objectPaths.size() == objectSpawnLocations.size()):
		return objectPaths.size()
	return 0
