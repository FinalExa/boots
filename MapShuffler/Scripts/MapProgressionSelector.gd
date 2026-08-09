class_name MapProgressionSelector
extends Node

@export var sceneSelector: SceneSelector
@export var rewardSpawn: RewardSpawn
@export var playerCharacter: PlayerCharacter

@export var startingDifficultyValue: float
@export var difficultyValueIncreaseOnComplete: float
@export var difficultyValueMaxValue: float
@export var gameMaxDifficulty: float

@export var levelStructureNormal: Array[MapFloorIndex]

var currentLevelStructure: Array[MapFloorIndex]
var currentDifficultyValue: float
var levelSelected: bool

var currentMap: MapData
var currentRoom: int
var mapChanged: bool

enum FloorTypes
{
	START,
	NORMAL,
	NO_REWARD,
	SHOP,
	MINIBOSS,
	BOSS,
	END
}

func _ready():
	InitalizeMaps()
	PickNewMap()

func InitalizeMaps():
	currentDifficultyValue = startingDifficultyValue
	currentRoom = 0
	SetLevelStructure(levelStructureNormal)

func SetLevelStructure(selectedStructure: Array[MapFloorIndex]):
	currentLevelStructure.clear()
	for i in selectedStructure.size():
		currentLevelStructure.push_back(selectedStructure[i])

func SetAndProgress(mapToSet: MapData):
	currentMap = mapToSet
	ProgressMap()
	
func ProgressMap():
	if (!levelSelected):
		if (currentRoom < levelStructureNormal.size()):
			SelectLevel()
		else:
			FinishCurrentMap()

func PickNewMap():
	playerCharacter.missionSelectPath.Open()

func FinishCurrentMap():
	currentDifficultyValue = clamp(currentDifficultyValue + difficultyValueIncreaseOnComplete, 0, difficultyValueMaxValue)
	currentMap.CompleteMap()
	currentRoom = 0
	playerCharacter.missionSelectPath.currentLocation.SetDone()
	if (!playerCharacter.missionSelectPath.CheckForEnd()):
		PickNewMap()
	else:
		get_tree().root.get_child(0).LoadHub()

func SelectLevel():
	levelSelected = true
	sceneSelector.SetScenePath(currentMap.PickLevel())
	currentRoom += 1
	sceneSelector.call_deferred("ShuffleScene")

func SetNextFloorInScene(gameplayScene: GameplayScene):
	if (currentRoom < currentLevelStructure.size()):
		gameplayScene.nextFloor = currentLevelStructure[currentRoom].floorType
		return
	gameplayScene.nextFloor = FloorTypes.END
