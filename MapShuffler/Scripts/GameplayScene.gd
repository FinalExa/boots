class_name GameplayScene
extends Node2D

@export var playerSpawnPoint: Node2D
@export var rewardSpawnPosition: Node2D
var door2Chance: int = 50
var door3Chance: int = 50
var completedObjective: bool
var doors: Array[Door]
var doorCount: int = 0

func SetPlayerSpawn(playerRef: PlayerCharacter):
	playerRef.global_position = playerSpawnPoint.global_position

func RegisterDoor(receivedDoor: Door):
	if (!doors.has(receivedDoor)):
		if (doorCount == 0):
			doors.push_back(receivedDoor)
			doorCount += 1
			return 0
		var randomValue: int = randi_range(1, 100)
		var neededNumberToPass: int
		if (doorCount == 1): neededNumberToPass = 100 - door2Chance
		else: neededNumberToPass = 100 - door3Chance
		doorCount += 1
		if (randomValue > neededNumberToPass):
			doors.push_back(receivedDoor)
			return 1
	return -1

func SetObjectiveCompleted():
	if (!completedObjective):
		rewardSpawnPosition.get_child(0).SpawnReward()
		completedObjective = true

func SetCompleted():
	var rewardSpawn: RewardSpawn = rewardSpawnPosition.get_child(0)
	if (rewardSpawn != null):
		rewardSpawn.reparent(get_tree().root.get_child(0))
	for i in doors.size():
		doors[i].call_deferred("OpenDoor")
