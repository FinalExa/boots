class_name MapProgressionSelector
extends Node

@export var sceneSelector: SceneSelector
@export var rewardSpawn: RewardSpawn

@export var startingDifficultyValue: float
@export var difficultyValueIncreaseOnComplete: float
@export var difficultyValueMaxValue: float
var currentDifficultyValue: float

@export var maps: Array[MapData]
var currentMap: MapData

func _ready():
	PickNewMap()
	InitalizeMaps()

func InitalizeMaps():
	for i in maps.size():
		maps[i].mapProgressionSelector = self
	currentDifficultyValue = startingDifficultyValue

func PickNewMap():
	currentMap = maps.pick_random()

func FinishCurrentMap():
	currentMap.CompleteMap()
	PickNewMap()
