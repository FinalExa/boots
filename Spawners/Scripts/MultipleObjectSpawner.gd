class_name MultipleObjectSpawner
extends ObjectSpawner

@export var objectPaths: Array[String]
@export var objectSpawnLocations: Array[Node2D]
var activeObjects: Array[Node2D]
var mapObjective: MapObjective

func SpawnObjects():
	ClearActiveObjects()
	if (self.is_inside_tree() && objectPaths.size() > 0 && objectPaths.size() == objectSpawnLocations.size()):
		for i in objectPaths.size():
			if (objectPaths[i] != ""):
				var newObj = CreateAndReturnObject(objectPaths[i], objectSpawnLocations[i])
				if (!activeObjects.has(newObj)): activeObjects.push_back(newObj)

func ClearActiveObjects():
	if (activeObjects.size() > 0):
		for i in activeObjects.size():
			if (activeObjects[i] != null):
				activeObjects[i].queue_free()
		activeObjects.clear()

func ReceivedCallFromDeletedSpawnedObject(object):
	if (activeObjects.has(object)):
		if (object is EnemyController): mapObjective.RequestEnemyData(object)
		activeObjects.erase(object)
		if (activeObjects.size() == 0 && mapObjective != null):
			if (mapObjective is DefeatWavesObjective):
				mapObjective.SpawnAndAdvanceWave()

func ReturnCount():
	if (objectPaths.size() > 0 && objectPaths.size() == objectSpawnLocations.size()):
		return objectPaths.size()
	return 0
