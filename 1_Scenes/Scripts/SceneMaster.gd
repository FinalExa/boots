class_name SceneMaster
extends Node2D

@export var frameMaster: FrameMaster
@export var sceneSelector: SceneSelector
@export var levelData: LevelData
@export var hubPath: String

func LoadHub():
	var rootRef = get_tree().root
	var activeSceneRef = rootRef.get_child(0)
	rootRef.remove_child(activeSceneRef)
	var obj_scene = load(hubPath)
	var hub: Hub = obj_scene.instantiate()
	levelData.SendData(hub.hubData)
	rootRef.add_child(hub)
	activeSceneRef.queue_free()
