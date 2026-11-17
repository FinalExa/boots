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
var availableMaps: Array[MapData]
var visitedMaps: Array[MapData]
var currentStep: int
var currentLocation: MapButton
var mapProgressionSelector: MapProgressionSelector

func _ready():
	Startup()

func Startup():
	currentStep = 0
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
	currentLocation = button
	mapProgressionSelector.SetAndProgress(button.associatedMap)
	Close()
	SetAvailableMaps()
	currentStep += 1

func PresetAllMaps():
	visitedMaps.clear()
	for i in maps.size():
		availableMaps.push_back(maps[i])

func SetAvailableMaps():
	if (currentStep == 0): PresetAllMaps()
	if (currentStep < totalSteps - 1):
		TwoButtons()
	else: OneButton()

func TwoButtons():
	pass

func OneButton():
	pass

func CheckForEnd():
	if (currentStep == totalSteps):
		return true
	return false
