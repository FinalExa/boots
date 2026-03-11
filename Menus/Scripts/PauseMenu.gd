class_name PauseMenu
extends Control

@export var playerRef: PlayerCharacter
@export var playerHubRef: PlayerHub
@export var hubButton: Button
var pauseInput: bool

func _ready():
	self.hide()
	if (playerHubRef != null):
		hubButton.hide()

func _process(_delta):
	GetPauseInput()
	TogglePause()

func GetPauseInput():
	if (Input.is_action_just_pressed("Pause")):
		pauseInput = true
		return
	pauseInput = false

func TogglePause():
	if (playerRef != null):
		if (pauseInput && !playerRef.inSelectMenu):
			if (!get_tree().paused):
				PauseOn()
			else:
				PauseOff()
	else:
		if (playerHubRef != null):
			if (pauseInput):
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

func ReturnToHub():
	if (playerRef != null):
		PauseOff()
		get_tree().root.get_child(0).LoadHub()
