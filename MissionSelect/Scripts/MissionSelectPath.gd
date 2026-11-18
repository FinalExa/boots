class_name MissionSelectPath
extends TextureRect

@export var playerRef: PlayerCharacter
@export var maps: Array[MapData]
@export var leftChoice: MapButton
@export var rightChoice: MapButton
@export var bonusChoice: MapButton
@export var finalChoice: MapButton
@export var destination: MapData
@export var totalSteps: int
@export var bonusBaseChance: int
@export var bonusChanceIncrease: int
var bonusCurrentChance: int
var currentMap: MapData
var availableMaps: Array[MapData]
var visitedMaps: Array[MapData]
var currentStep: int
var mapProgressionSelector: MapProgressionSelector

func _ready():
	Startup()

func Startup():
	currentStep = 0
	bonusCurrentChance = bonusBaseChance
	mapProgressionSelector = playerRef.mapProgressionSelector
	for i in maps.size():
		if (maps[i].mapProgressionSelector == null):
			maps[i].mapProgressionSelector = mapProgressionSelector
	SetAvailableMaps()

func Open():
	self.show()
	playerRef.inSelectMenu = true
	get_tree().paused = true

func Close():
	playerRef.inSelectMenu = false
	get_tree().paused = false
	self.hide()

func ButtonPressed(button: MapButton):
	mapProgressionSelector.SetAndProgress(button.associatedMap)
	visitedMaps.push_back(button.associatedMap)
	currentMap = button.associatedMap
	ReturnUnchosenMaps(button)
	Close()
	SetAvailableMaps()
	if (button != bonusChoice): currentStep += 1

func PresetAllMaps():
	visitedMaps.clear()
	for i in maps.size():
		availableMaps.push_back(maps[i])
	visitedMaps.push_back(destination)
	availableMaps.erase(destination)

func SetAvailableMaps():
	if (currentStep == 0): PresetAllMaps()
	if (currentStep < totalSteps - 1):
		NormalStep()
	else: FinalStep()

func ReturnUnchosenMaps(button: MapButton):
	if (button != leftChoice):
		availableMaps.push_back(leftChoice.associatedMap)
	if (button != rightChoice):
		availableMaps.push_back(rightChoice.associatedMap)
	if (button != bonusChoice):
		availableMaps.push_back(bonusChoice.associatedMap)

func NormalStep():
	leftChoice.SetMap(PickAvailableMap())
	leftChoice.ShowButton()
	rightChoice.SetMap(PickAvailableMap())
	rightChoice.ShowButton()
	if (currentStep > 0 && RollBonusChoice()):
		bonusChoice.SetMap(PickAvailableMap())
		bonusChoice.ShowButton()
	else:
		bonusChoice.HideButton()
	finalChoice.HideButton()

func RollBonusChoice():
	if (availableMaps.size() <= (totalSteps - currentStep) + 2):
		return false
	if (randi_range(1, 100) <= bonusCurrentChance):
		bonusCurrentChance = bonusBaseChance
		return true
	bonusCurrentChance += bonusChanceIncrease
	return false

func FinalStep():
	finalChoice.SetMap(destination)
	finalChoice.ShowButton()
	leftChoice.HideButton()
	rightChoice.HideButton()
	bonusChoice.HideButton()

func PickAvailableMap():
	var chosenMap: MapData = availableMaps.pick_random()
	availableMaps.erase(chosenMap)
	return chosenMap

func CheckForEnd():
	if (currentStep == totalSteps):
		return true
	return false
