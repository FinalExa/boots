class_name ObjectSpawner
extends Node2D

@export var objectPath: String

func SpawnObject():
	if (self.is_inside_tree()):
		if (objectPath != ""):
			var sceneMaster: SceneMaster = get_tree().root.get_child(0)
			var obj_scene = load(objectPath)
			var obj = obj_scene.instantiate()
			obj.global_position = self.global_position
			obj.global_rotation = self.global_rotation
			if (sceneMaster != null):
				sceneMaster.sceneSelector.currentScene.add_child(obj)
			return obj
	else:
		queue_free()
		return null
