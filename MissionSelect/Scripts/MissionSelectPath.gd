class_name MissionSelectPath
extends TextureRect

@export var playerRef: PlayerCharacter
@export var maps: Array[TextureButton]
@export var startLocation: TextureButton
@export var endLocation: TextureButton
@export var positionArrow: AnimatedSprite2D
@export var endArrow: AnimatedSprite2D
var currentLocation: TextureButton
var mapProgressionSelector: MapProgressionSelector

func _ready():
	Startup()

func Startup():
	mapProgressionSelector = playerRef.mapProgressionSelector
	endArrow.global_position = endLocation.global_position + (endLocation.size/2)
	positionArrow.global_position = startLocation.global_position + (startLocation.size/2)
	for i in maps.size():
		if (maps[i].missionSelectPath == null):
			maps[i].missionSelectPath = self
		if (maps[i].associatedMap.mapProgressionSelector == null):
			maps[i].associatedMap.mapProgressionSelector = mapProgressionSelector
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
	positionArrow.global_position = currentLocation.global_position + (currentLocation.size/2)
	mapProgressionSelector.SetAndProgress(button.associatedMap)
	Close()
	SetAvailableMaps()

func PresetAllMaps():
	for i in maps.size():
		if (!maps[i].done):
			maps[i].disabled = false
		else:
			maps[i].disabled = true

func SetAvailableMaps():
	PresetAllMaps()
	if (currentLocation == null):
		for i in maps.size():
			if (maps[i] != startLocation):
				maps[i].disabled = true
	else:
		for i in maps.size():
			if (!currentLocation.adjacentMaps.has(maps[i])):
				maps[i].disabled = true

func CheckForEnd():
	if (currentLocation == endLocation):
		return true
	return false
