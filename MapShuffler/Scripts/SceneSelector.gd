class_name SceneSelector
extends Node2D

@export var scenesToShuffle: Array[String]
@export var shopScene: String
@export var playerRef: PlayerCharacter
@export var safePosition: Vector2
@export var rewardSpawn: RewardSpawn
var currentScene: GameplayScene

func _ready():
	call_deferred("ShuffleScene")

func ShuffleScene():
	playerRef.global_position = safePosition
	playerRef.playerShooting.Refull()
	rewardSpawn.GenerateRewardType()
	if (currentScene != null):
		remove_child(currentScene)
		currentScene.queue_free()
		currentScene = null
	var obj = GetCorrectScene().instantiate()
	currentScene = obj
	add_child(currentScene)
	currentScene.SetPlayerSpawn(playerRef)
	playerRef.playerMovements.SetToZero()
	rewardSpawn.reparent(currentScene.rewardSpawnPosition)
	rewardSpawn.global_position = currentScene.rewardSpawnPosition.global_position
	SpecialRoomTypeOperations()
	playerRef.UpdateCurrentRoomCount(str(rewardSpawn.roomNumber))

func GetCorrectScene():
	var scene
	if (rewardSpawn.rewardType != RewardSpawn.RewardType.SHOP):
		scene = load(scenesToShuffle[randf_range(0, scenesToShuffle.size())])
	else:
		scene = load(shopScene)
	return scene

func SpecialRoomTypeOperations():
	if (rewardSpawn.rewardType == RewardSpawn.RewardType.SHOP):
		currentScene.SetObjectiveCompleted()
