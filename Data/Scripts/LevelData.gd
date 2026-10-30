class_name LevelData
extends Node

@export var playerCharacter: PlayerCharacter
var savedAbilityID: int

func ReceiveAbility(ability: AbilityData, abilityIndex: int):
	savedAbilityID = abilityIndex
	playerCharacter.playerAbilities.AddAbility2(ability)

func SendData(hubData: HubData):
	hubData.PreSetAbility(savedAbilityID)
