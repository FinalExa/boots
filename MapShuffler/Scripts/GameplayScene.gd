class_name GameplayScene
extends Node2D

@export var playerSpawnPoint: Node2D
var doors: Array[Door]

func SetPlayerSpawn(playerRef: PlayerCharacter):
	playerRef.global_position = playerSpawnPoint.global_position

func RegisterDoor(receivedDoor: Door):
	if (!doors.has(receivedDoor)):
		doors.push_back(receivedDoor)

func SetCompleted():
	for i in doors.size():
		doors[i].call_deferred("OpenDoor")
