class_name PauseMenu
extends Control

@export var playerInputs: PlayerInputs

func _ready():
	self.hide()

func _process(_delta):
	TogglePause()

func TogglePause():
	if (playerInputs.pauseInput):
		if (!get_tree().paused):
			PauseOn()
		else:
			PauseOff()

func PauseOn():
	playerInputs.pauseInput = false
	self.show()
	get_tree().paused = true

func PauseOff():
	playerInputs.pauseInput = false
	self.hide()
	get_tree().paused = false

func Quit():
	get_tree().quit()
