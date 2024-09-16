class_name MapProgressionSelector
extends Node

@export var sceneSelector: SceneSelector
@export var rewardSpawn: RewardSpawn

@export var startingDifficultyValue: float
@export var difficultyValueIncreaseOnComplete: float
@export var difficultyValueMaxValue: float
@export var gameMaxDifficulty: float
var currentDifficultyValue: float

@export var maps: Array[MapData]
var currentMap: MapData

func _ready():
	InitalizeMaps()

func InitalizeMaps():
	for i in maps.size():
		maps[i].mapProgressionSelector = self
	currentDifficultyValue = startingDifficultyValue

func ProgressMap():
	if (currentMap == null):
		PickNewMap()
	if (currentMap.currentFloor < currentMap.mapFloors.size()):
		currentMap.PickLevel()
	else:
		FinishCurrentMap()

func PickNewMap():
	currentMap = maps.pick_random()

func FinishCurrentMap():
	currentDifficultyValue = clamp(currentDifficultyValue + difficultyValueIncreaseOnComplete, 0, difficultyValueMaxValue)
	currentMap.CompleteMap()
	PickNewMap()
	currentMap.PickLevel()
