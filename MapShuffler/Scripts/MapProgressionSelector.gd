class_name MapProgressionSelector
extends Node

@export var sceneSelector: SceneSelector
@export var rewardSpawn: RewardSpawn
@export var playerCharacter: PlayerCharacter

@export var startingDifficultyValue: float
@export var difficultyValueIncreaseOnComplete: float
@export var difficultyValueMaxValue: float
@export var gameMaxDifficulty: float
var currentDifficultyValue: float
var levelSelected: bool

var currentMap: MapData
var mapChanged: bool

func _ready():
	InitalizeMaps()
	PickNewMap()

func InitalizeMaps():
	currentDifficultyValue = startingDifficultyValue

func SetAndProgress(mapToSet: MapData):
	currentMap = mapToSet
	ProgressMap()
	
func ProgressMap():
	if (!levelSelected):
		if (currentMap.currentFloor < currentMap.mapFloors.size()):
			SelectLevel()
		else:
			FinishCurrentMap()

func PickNewMap():
	playerCharacter.missionSelectPath.Open()

func FinishCurrentMap():
	currentDifficultyValue = clamp(currentDifficultyValue + difficultyValueIncreaseOnComplete, 0, difficultyValueMaxValue)
	currentMap.CompleteMap()
	playerCharacter.missionSelectPath.currentLocation.SetDone()
	if (!playerCharacter.missionSelectPath.CheckForEnd()):
		PickNewMap()
	else:
		get_tree().root.get_child(0).LoadHub()

func SelectLevel():
	levelSelected = true
	sceneSelector.SetScenePath(currentMap.PickLevel())
	sceneSelector.call_deferred("ShuffleScene")
