class_name GameplayScene
extends Node2D

@export var playerSpawnPoint: Node2D
@export var rewardSpawnPosition: Node2D
var completedObjective: bool
var doors: Array[Door]

func SetPlayerSpawn(playerRef: PlayerCharacter):
	playerRef.global_position = playerSpawnPoint.global_position

func RegisterDoor(receivedDoor: Door):
	if (!doors.has(receivedDoor)):
		doors.push_back(receivedDoor)

func SetObjectiveCompleted():
	if (!completedObjective):
		rewardSpawnPosition.get_child(0).SpawnReward()
		completedObjective = true

func SetCompleted():
	rewardSpawnPosition.get_child(0).reparent(get_tree().root.get_child(0))
	for i in doors.size():
		doors[i].call_deferred("OpenDoor")
