class_name MapButton
extends TextureButton

@export var associatedMap: MapData
@export var adjacentMaps: Array[MapButton]
var missionSelectPath: MissionSelectPath
var done: bool

func OnPress():
	missionSelectPath.ButtonPressed(self)

func SetDone():
	done = true
