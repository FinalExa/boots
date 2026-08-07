class_name MapData
extends Node

@export var mapName: String
@export var mapLevels: Array[MapLevel]
@export var mapFloors: Array[FloorTypes]
@export var mapMinDifficulty: Array[float]
@export var mapMaxDifficulty: Array[float]
var bannedLevels: Array[String]
var mapProgressionSelector: MapProgressionSelector
var currentFloor: int
var currentMapPath: String

enum FloorTypes
{
	START,
	NORMAL,
	NO_REWARD,
	SHOP,
	MINIBOSS,
	BOSS
}

func PickLevel():
	LevelSelectionCases()
	currentFloor += 1
	return currentMapPath

func LevelSelectionCases():
	if (mapFloors[currentFloor] == FloorTypes.START):
		mapProgressionSelector.rewardSpawn.roomNumber = 0
		mapProgressionSelector.rewardSpawn.GenerateRewardType()
		GetMapInDifficultyRange()
		mapProgressionSelector.rewardSpawn.roomNumber = 0
		return
	if (mapFloors[currentFloor] == FloorTypes.NORMAL):
		GetMapInDifficultyRange()
		return

func GetMapInDifficultyRange():
	var minRange = ClampDifficulty(mapProgressionSelector.currentDifficultyValue + mapMinDifficulty[currentFloor])
	var maxRange = ClampDifficulty(mapProgressionSelector.currentDifficultyValue + mapMaxDifficulty[currentFloor])
	var possibleMaps: Array[String] = []
	for difficultyIndex in mapLevels.size():
		if (difficultyIndex >= minRange && difficultyIndex <= maxRange):
			var mapsArray: Array[String] = mapLevels[difficultyIndex].associatedLevels
			for i in mapsArray.size():
				if (!bannedLevels.has(mapsArray[i])):
					possibleMaps.push_back(mapsArray[i])
	var pickedMap: String = possibleMaps.pick_random()
	for i in mapLevels.size():
		bannedLevels.push_back(pickedMap)
	currentMapPath = pickedMap

func ClampDifficulty(valueToClamp: float):
	return clamp(valueToClamp, 0, mapProgressionSelector.gameMaxDifficulty)

func CompleteMap():
	currentFloor = 0
	ResetBannedLevels()

func ResetBannedLevels():
	bannedLevels.clear()
