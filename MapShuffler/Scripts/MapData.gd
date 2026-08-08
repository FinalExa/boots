class_name MapData
extends Node

@export var mapName: String
@export var mapLevels: Array[MapLevel]
@export var shopLevel: String
var bannedLevels: Array[String]
var mapProgressionSelector: MapProgressionSelector
var currentFloor: int
var currentMapPath: String

func PickLevel():
	LevelSelectionCases()
	currentFloor += 1
	return currentMapPath

func LevelSelectionCases():
	var currentFloorType: MapProgressionSelector.FloorTypes = mapProgressionSelector.currentLevelStructure[mapProgressionSelector.currentRoom].floorType
	if (currentFloorType == MapProgressionSelector.FloorTypes.START):
		mapProgressionSelector.rewardSpawn.roomNumber = 0
		mapProgressionSelector.rewardSpawn.GenerateRewardType()
		GetMapInDifficultyRange()
		mapProgressionSelector.rewardSpawn.roomNumber = 0
		return
	if (currentFloorType == MapProgressionSelector.FloorTypes.NORMAL):
		GetMapInDifficultyRange()
		return

func GetMapInDifficultyRange():
	var minRange: float = ClampDifficulty(mapProgressionSelector.currentDifficultyValue + mapProgressionSelector.currentLevelStructure[mapProgressionSelector.currentRoom].floorMinDifficultyRange)
	var maxRange: float = ClampDifficulty(mapProgressionSelector.currentDifficultyValue + mapProgressionSelector.currentLevelStructure[mapProgressionSelector.currentRoom].floorMaxDifficultyRange)
	var possibleMaps: Array[String] = GetMapRangeArray(minRange, maxRange)
	if (possibleMaps.size() == 0):
		AntiSoftlock(minRange, maxRange)
		GetMapRangeArray(minRange, maxRange)
	var pickedMap: String = possibleMaps.pick_random()
	for i in mapLevels.size():
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
	currentFloor = 0
	ResetBannedLevels()

func ResetBannedLevels():
	bannedLevels.clear()
