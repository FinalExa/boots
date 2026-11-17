class_name MapButton
extends TextureButton

@export var associatedMap: MapData
var missionSelectPath: MissionSelectPath
var done: bool

func OnPress():
	missionSelectPath.ButtonPressed(self)

func SetDone():
	done = true

func UnsetDone():
	done = false
