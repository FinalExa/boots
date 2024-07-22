class_name SceneSelector
extends Node2D

@export var scenesToShuffle: Array[String]
@export var playerRef: PlayerCharacter
@export var safePosition: Vector2
@export var rewardSpawn: RewardSpawn
var currentScene: GameplayScene

func _ready():
	call_deferred("ShuffleScene")

func ShuffleScene():
	playerRef.global_position = safePosition
	if (currentScene != null):
		remove_child(currentScene)
		currentScene.queue_free()
		currentScene = null
	var obj_scene = load(scenesToShuffle[randf_range(0, scenesToShuffle.size())])
	var obj = obj_scene.instantiate()
	currentScene = obj
	add_child(currentScene)
	currentScene.SetPlayerSpawn(playerRef)
	playerRef.playerMovements.SetToZero()
	rewardSpawn.reparent(currentScene.rewardSpawnPosition)
	rewardSpawn.global_position = currentScene.rewardSpawnPosition.global_position
	rewardSpawn.GenerateRewardType()
	playerRef.UpdateCurrentRoomCount(str(rewardSpawn.roomNumber))
