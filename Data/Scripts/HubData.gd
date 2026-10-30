class_name HubData
extends Node

@export var playerHub: PlayerHub
@export var abilities: Array[AbilityData]
@export var baseAbilityID: int
var selectedAbilityID: int
var preSet: bool

func _ready():
	GetAbilityID()
	playerHub.abilitySelectScreen.GenerateDataButtons()

func SetAbilityID(id: int):
	selectedAbilityID = id

func GetAbilityID():
	if (!preSet):
		selectedAbilityID = LoadID()
		if (selectedAbilityID == -1):
			selectedAbilityID = baseAbilityID

func LoadID():
	return -1

func SendData(levelData: LevelData):
	levelData.ReceiveAbility(abilities[selectedAbilityID], selectedAbilityID)

func PreSetAbility(abilityID: int):
	selectedAbilityID = abilityID
	preSet = true
