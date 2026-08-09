class_name SceneMaster
extends Node2D

@export var frameMaster: FrameMaster
@export var sceneSelector: SceneSelector
@export var hubPath: String

func LoadHub():
	call_deferred("ActuallyLoadHub")

func ActuallyLoadHub():
	var rootRef = get_tree().root
	var activeSceneRef = rootRef.get_child(0)
	rootRef.remove_child(activeSceneRef)
	var obj_scene = load(hubPath)
	var hub: Node2D = obj_scene.instantiate()
	rootRef.add_child(hub)
	activeSceneRef.queue_free()
