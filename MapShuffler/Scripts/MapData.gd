class_name MapData
extends Node

@export var mapName: String
@export var mapLevels: Array[MapLevel]
@export var shopLevel: String
@export var bossLevel: String
var bannedLevels: Array[String]
var mapProgressionSelector: MapProgressionSelector
var currentMapPath: String

func PickLevel():
	LevelSelectionCases()
	return currentMapPath

func LevelSelectionCases():
	var currentFloorType: MapProgressionSelector.FloorTypes = mapProgressionSelector.currentLevelStructure[mapProgressionSelector.currentRoom].floorType
	if (currentFloorType == MapProgressionSelector.FloorTypes.START):
		mapProgressionSelector.rewardSpawn.GenerateRewardType()
		GetMapInDifficultyRange()
		return
	GetMapInDifficultyRange()

func GetMapInDifficultyRange():
	var minRange: float = ClampDifficulty(mapProgressionSelector.currentDifficultyValue + mapProgressionSelector.currentLevelStructure[mapProgressionSelector.currentRoom].floorMinDifficultyRange)
	var maxRange: float = ClampDifficulty(mapProgressionSelector.currentDifficultyValue + mapProgressionSelector.currentLevelStructure[mapProgressionSelector.currentRoom].floorMaxDifficultyRange)
	var possibleMaps: Array[String] = GetMapRangeArray(minRange, maxRange)
	if (possibleMaps.size() == 0):
		AntiSoftlock(minRange, maxRange)
		possibleMaps = GetMapRangeArray(minRange, maxRange)
	var pickedMap: String = possibleMaps.pick_random()
	bannedLevels.push_back(pickedMap)
	currentMapPath = pickedMap

func GetMapRangeArray(minRange: float, maxRange: float):
	var possibleMaps: Array[String] = []
	for difficultyIndex in mapLevels.size():
		if (difficultyIndex >= minRange && difficultyIndex <= maxRange):
			var mapsArray: Array[String] = mapLevels[difficultyIndex].associatedLevels
			for i in mapsArray.size():
				if (!bannedLevels.has(mapsArray[i])):
					possibleMaps.push_back(mapsArray[i])
	return possibleMaps

func AntiSoftlock(minRange: float, maxRange: float):
	for difficultyIndex in mapLevels.size():
		if (difficultyIndex >= minRange && difficultyIndex <= maxRange):
			var i: int = mapLevels[difficultyIndex].associatedLevels.size() - 1
			while (i >= 0):
				if (bannedLevels.has(mapLevels[difficultyIndex].associatedLevels[i])):
					bannedLevels.remove_at(i)
				i -= 1

func ClampDifficulty(valueToClamp: float):
	return clamp(valueToClamp, 0, mapProgressionSelector.gameMaxDifficulty)

func CompleteMap():
	ResetBannedLevels()

func ResetBannedLevels():
	bannedLevels.clear()
