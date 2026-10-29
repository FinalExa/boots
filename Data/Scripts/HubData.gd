class_name HubData
extends Node

@export var abilities: Array[AbilityData]
@export var baseAbilityID: int
var selectedAbilityID: int

func _ready():
	GetAbilityID()

func SetAbilityID(id: int):
	selectedAbilityID = id

func GetAbilityID():
	selectedAbilityID = LoadID()
	if (selectedAbilityID == -1):
		selectedAbilityID = baseAbilityID

func LoadID():
	return -1

func SendData(levelData: LevelData):
	levelData.ReceiveAbility(abilities[selectedAbilityID])
