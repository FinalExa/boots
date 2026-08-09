class_name SceneSelector
extends Node2D

@export var shopScene: String
@export var playerRef: PlayerCharacter
@export var safePosition: Vector2
@export var rewardSpawn: RewardSpawn
@export var mapProgressionSelector: MapProgressionSelector
var scenePath: String
var currentScene: GameplayScene

func ShuffleScene():
	mapProgressionSelector.ProgressMap()
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
	playerRef.UpdateCurrentRoomCount(str(mapProgressionSelector.currentRoom))

func GetCorrectScene():
	if (rewardSpawn.rewardType != RewardSpawn.RewardType.SHOP):
		return load(scenePath)
	return load(shopScene)

func SpecialRoomTypeOperations():
	if (rewardSpawn.rewardType == RewardSpawn.RewardType.SHOP):
		currentScene.SetObjectiveCompleted()

func SetScenePath(receivedPath: String):
	scenePath = receivedPath
