class_name PlayerPassiveObject
extends Node2D

@export var passiveReferenced: PlayerCharacter.Player

func IsHit(body):
	if (body is PlayerCharacter):
		if (body.playerID == passiveReferenced):
			PlayerPasses(body)
		else:
			PlayerFails(body)

func PlayerPasses(playerRef: PlayerCharacter):
	pass

func PlayerFails(playerRef: PlayerCharacter):
	pass
