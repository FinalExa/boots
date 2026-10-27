class_name PlayerPassiveObject
extends Node2D

@export var passiveReferenced: PlayerCharacter.Player
var playerRef: PlayerCharacter

func _ready():
	ReadyOperations()

func _process(delta):
	PlayerCheck()
	ProcessOperations(delta)

func ReadyOperations():
	pass

func ProcessOperations(_delta):
	pass

func PlayerCheck():
	if (playerRef != null):
		if (playerRef.playerID == passiveReferenced):
			PlayerPasses(playerRef)
		else:
			PlayerFails(playerRef)

func PlayerIn(body):
	if (body is PlayerCharacter):
		playerRef = body

func PlayerLeaves(body):
	if (body is PlayerCharacter):
		playerRef = null

func PlayerPasses(_player: PlayerCharacter):
	pass

func PlayerFails(_player: PlayerCharacter):
	pass
