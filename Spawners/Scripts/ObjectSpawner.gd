class_name ObjectSpawner
extends Node2D

@export var objectPath: String
@export var setAsChild: bool

func SpawnObject():
	if (self.is_inside_tree() && objectPath != ""):
		return CreateAndReturnObject(objectPath, self)
	else:
		queue_free()
		return null

func CreateAndReturnObject(objectToCreate: String, objectPositionRef: Node2D):
	var obj_scene = load(objectToCreate)
	var obj = obj_scene.instantiate()
	call_deferred("AddObjectToScene", obj, objectPositionRef)
	if (obj is EnemyController): obj.SetSpawnerRef(self)
	return obj

func AddObjectToScene(object, objectPositionRef: Node2D):
	if (!setAsChild):
		var sceneMaster: SceneMaster = get_tree().root.get_child(0)
		if (sceneMaster != null):
			sceneMaster.sceneSelector.currentScene.add_child(object)
	else:
		self.add_child(object)
	object.global_position = objectPositionRef.global_position
	object.global_rotation = objectPositionRef.global_rotation

func ReceivedCallFromDeletedSpawnedObject(_object):
	pass
