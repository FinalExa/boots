class_name PowerUpUI
extends Control

@export var playerRef: PlayerCharacter
@export var powerUpButtons: Array[Button]

func _ready():
	self.hide()

func RegisterPowerUps(receivedPowerUps: Array[PowerUp]):
	for i in receivedPowerUps.size():
		receivedPowerUps[i].reparent(powerUpButtons[i])
		powerUpButtons[i].text = str(receivedPowerUps[i].powerUpName, "\n", receivedPowerUps[i].powerUpDescription)
	get_tree().paused = true
	self.show()

func OnButtonPressed(extra_arg_0):
	var selectedPowerUp: PowerUp = powerUpButtons[extra_arg_0].get_child(0)
	selectedPowerUp.reparent(playerRef.powerUpManager)
	selectedPowerUp.global_position = playerRef.powerUpManager.global_position
	selectedPowerUp.global_rotation = playerRef.powerUpManager.global_rotation
	selectedPowerUp.powerUpManager = selectedPowerUp.get_parent()
	selectedPowerUp.Register()
	ClearPowerUps()
	get_tree().paused = false
	self.hide()

func ClearPowerUps():
	for i in powerUpButtons.size():
		if (powerUpButtons[i].get_child_count() > 0):
			var objToRemove = powerUpButtons[i].get_child(0)
			powerUpButtons[i].remove_child(objToRemove)
			objToRemove.queue_free()
