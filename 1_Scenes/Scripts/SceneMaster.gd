class_name SceneMaster
extends Node2D

@export var frameMaster: FrameMaster
@export var sceneSelector: SceneSelector
@export var hubPath: String

func LoadHub():
	var rootRef = get_tree().root
	var activeSceneRef = rootRef.get_child(0)
	rootRef.remove_child(activeSceneRef)
	var obj_scene = load(hubPath)
	var sceneMaster: SceneMaster = obj_scene.instantiate()
	sceneMaster.sceneSelector.playerRef.global_position = sceneMaster.sceneSelector.safePosition
	rootRef.add_child(sceneMaster)
	activeSceneRef.queue_free()
