class_name MapButton
extends TextureButton

signal mapSelected(button)

var associatedMap: MapData
@export var mapTexture: TextureRect
@export var areaNameLabel: Label
@export var pathTypeLabel: Label
@export var pathTypeText: String

func _ready():
	SetTypeText()

func SetTypeText():
	pathTypeLabel.text = pathTypeText

func SetMap(mapData: MapData):
	associatedMap = mapData
	areaNameLabel.text = mapData.mapName
	mapTexture.texture = mapData.mapIcon

func OnPress():
	emit_signal("mapSelected", self)

func ShowButton():
	self.show()

func HideButton():
	self.hide()
