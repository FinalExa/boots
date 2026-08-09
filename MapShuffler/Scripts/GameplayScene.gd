class_name GameplayScene
extends Node2D

@export var playerSpawnPoint: Node2D
@export var rewardSpawnPosition: Node2D
var nextFloor: MapProgressionSelector.FloorTypes
var objective: MapObjective
var doorChances: Array[int] = [80, 20]
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
		if (doorCount == 1 && nextFloor == MapProgressionSelector.FloorTypes.SHOP):
			doors.push_back(receivedDoor)
			return 1
		if (!SingleDoorCases() && DoorRandomCheck(100 - doorChances[doorCount - 1])):
			doors.push_back(receivedDoor)
			return 1
	return -1

func SingleDoorCases():
	if (nextFloor == MapProgressionSelector.FloorTypes.NO_REWARD ||
	nextFloor == MapProgressionSelector.FloorTypes.MINIBOSS ||
	nextFloor == MapProgressionSelector.FloorTypes.BOSS ||
	nextFloor == MapProgressionSelector.FloorTypes.END):
		return true
	return false

func DoorRandomCheck(passNumber: int):
	var randomValue: int = randi_range(1, 100)
	doorCount += 1
	if (randomValue > passNumber):
		return true
	return false

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
