class_name PauseMenu
extends Control

@export var playerRef: PlayerCharacter
var pauseInput: bool

func _ready():
	self.hide()

func _process(_delta):
	GetPauseInput()
	TogglePause()

func GetPauseInput():
	if (Input.is_action_just_pressed("Pause")):
		pauseInput = true
		return
	pauseInput = false

func TogglePause():
	if (pauseInput && !playerRef.inSelectMenu):
		if (!get_tree().paused):
			PauseOn()
		else:
			PauseOff()

func PauseOn():
	pauseInput = false
	self.show()
	get_tree().paused = true

func PauseOff():
	pauseInput = false
	self.hide()
	get_tree().paused = false

func Quit():
	get_tree().quit()
