class_name MapData
extends Node

@export var mapName: String
@export var mapDifficultyLevels: Array[MapDifficultyLevel]
@export var mapFloors: Array[FloorTypes]
@export var mapMinDifficulty: Array[float]
@export var mapMaxDifficulty: Array[float]
var mapProgressionSelector: MapProgressionSelector
var currentFloor: int

enum FloorTypes
{
	START,
	NORMAL,
	SHOP,
	BOSS
}

func PickLevel():
	LevelSelectionCases()

func LevelSelectionCases():
	if (mapFloors[currentFloor] == FloorTypes.START):
		mapProgressionSelector.rewardSpawn.roomNumber = 0
		mapProgressionSelector.rewardSpawn.GenerateRewardType()

func CompleteMap():
	ResetBannedLevels()

func ResetBannedLevels():
	for i in mapDifficultyLevels.size():
		mapDifficultyLevels[i].ResetSelectedLevels()
