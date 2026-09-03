class_name PowerUpSelector
extends Control

signal buttonPressed(buttonId)

@export var button: Button
@export var buttonId: int
@export var upgradeLabel: Label
@export var baseUpgradeText: String

func _ready():
	HideUpgradeLabel()

func onButtonPressed():
	emit_signal("buttonPressed", buttonId)

func ShowUpgradeLabel(upgradeName: String):
	upgradeLabel.text = str(baseUpgradeText, upgradeName)
	upgradeLabel.show()

func HideUpgradeLabel():
	upgradeLabel.text = ""
	upgradeLabel.hide()
