class_name GameplayScene
extends Node2D

@export var playerSpawnPoint: Node2D
@export var rewardSpawnPosition: Node2D
var doors: Array[Door]

func SetPlayerSpawn(playerRef: PlayerCharacter):
	playerRef.global_position = playerSpawnPoint.global_position

func RegisterDoor(receivedDoor: Door):
	if (!doors.has(receivedDoor)):
		doors.push_back(receivedDoor)

func SetObjectiveCompleted():
	rewardSpawnPosition.get_child(0).SpawnReward()

func SetCompleted():
	rewardSpawnPosition.get_child(0).reparent(get_tree().root.get_child(0))
	for i in doors.size():
		doors[i].call_deferred("OpenDoor")
