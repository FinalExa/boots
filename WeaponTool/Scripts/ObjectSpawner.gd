class_name ObjectSpawner
extends Node2D

@export var objectPath: String

func SpawnObject():
	if (objectPath != ""):
		var obj_scene = load(objectPath)
		var obj = obj_scene.instantiate()
		obj.global_position = self.global_position
		obj.global_rotation = self.global_rotation
		get_tree().root.get_child(0).sceneSelector.currentScene.add_child(obj)
