class_name LevelData
extends Node

@export var playerCharacter: PlayerCharacter

func ReceiveAbility(ability: AbilityData):
	playerCharacter.playerAbilities.AddAbility2(ability)
