class_name AbilitySelector
extends Node2D

@export var playerHubRef: PlayerHub
@export var hubData: HubData

func OpenSelectionScreen():
	pass

func SetAbilityID(returnedID: int):
	hubData.SetAbilityID(returnedID)
