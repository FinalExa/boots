class_name ObjectSpawner
extends Node2D

@export var objectPath: String

func SpawnObject():
	if (self.is_inside_tree() && objectPath != ""):
		return CreateAndReturnObject(objectPath, self)
	else:
		queue_free()
		return null

func CreateAndReturnObject(objectToCreate: String, objectPositionRef: Node2D):
	var obj_scene = load(objectToCreate)
	var obj = obj_scene.instantiate()
	obj.global_position = objectPositionRef.global_position
	obj.global_rotation = objectPositionRef.global_rotation
	call_deferred("AddObjectToScene", obj)
	if (obj is EnemyController): obj.SetSpawnerRef(self)
	return obj

func AddObjectToScene(object):
	var sceneMaster: SceneMaster = get_tree().root.get_child(0)
	if (sceneMaster != null):
		sceneMaster.sceneSelector.currentScene.add_child(object)

func ReceivedCallFromDeletedSpawnedObject(object):
	pass
