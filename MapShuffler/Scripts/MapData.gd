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
	currentFloor += 1

func LevelSelectionCases():
	if (mapFloors[currentFloor] == FloorTypes.START):
		mapProgressionSelector.rewardSpawn.roomNumber = 0
		mapProgressionSelector.rewardSpawn.GenerateRewardType()
		GetMapInDifficultyRange()
		return
	if (mapFloors[currentFloor] == FloorTypes.NORMAL):
		GetMapInDifficultyRange()
		return

func GetMapInDifficultyRange():
	var minRange = ClampDifficulty(mapProgressionSelector.currentDifficultyValue + mapMinDifficulty[currentFloor])
	var maxRange = ClampDifficulty(mapProgressionSelector.currentDifficultyValue + mapMaxDifficulty[currentFloor])
	var possibleMaps: Array[String] = []
	for difficultyIndex in mapDifficultyLevels.size():
		if (difficultyIndex >= minRange && difficultyIndex <= maxRange):
			var arrayToAdd: Array[String] = mapDifficultyLevels[difficultyIndex].associatedLevels
			for i in arrayToAdd.size():
				possibleMaps.push_back(arrayToAdd[i])
	var pickedMap: String = possibleMaps.pick_random()
	for i in mapDifficultyLevels.size():
		mapDifficultyLevels[i].SelectLevel(pickedMap)
	print(str(mapName, " ", currentFloor, "\n", "Range: ", minRange, "-", maxRange, " Current difficulty value: ", mapProgressionSelector.currentDifficultyValue, "\n", pickedMap, "\n"))

func ClampDifficulty(valueToClamp: float):
	return clamp(valueToClamp, 0, mapProgressionSelector.gameMaxDifficulty)

func CompleteMap():
	currentFloor = 0
	ResetBannedLevels()

func ResetBannedLevels():
	for i in mapDifficultyLevels.size():
		mapDifficultyLevels[i].ResetSelectedLevels()
