class_name MapButton
extends TextureButton

signal mapSelected(button)

@export var associatedMap: MapData

func SetMap(mapData: MapData):
	self.texture_normal = mapData.normalTexture
	self.texture_pressed = mapData.pressedTexture
	self.texture_hover = mapData.hoverTexture

func OnPress():
	emit_signal("mapSelected", self)

func ShowButton():
	self.show()

func HideButton():
	self.hide()
