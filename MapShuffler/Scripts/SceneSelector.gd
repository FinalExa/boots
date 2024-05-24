class_name SceneSelector
extends Node2D

@export var scenesToShuffle: Array[String]
@export var playerRef: PlayerCharacter
@export var safePosition: Vector2
var currentScene: GameplayScene

func _ready():
	ShuffleScene()

func ShuffleScene():
	playerRef.global_position = safePosition
	if (currentScene != null):
		remove_child(currentScene)
		currentScene = null
	var obj_scene = load(scenesToShuffle[randf_range(0, scenesToShuffle.size() - 1)])
	var obj = obj_scene.instantiate()
	add_child(obj)
	currentScene = get_child(0)
	currentScene.SetPlayerSpawn(playerRef)
