class_name PowerUpUI
extends Control

@export var playerRef: PlayerCharacter
@export var powerUpSelectors: Array[PowerUpSelector]
var rewardSpawn: RewardSpawn

func _ready():
	rewardSpawn = get_tree().root.get_child(0).sceneSelector.rewardSpawn
	self.hide()

func RegisterPowerUps(receivedPowerUps: Array[PowerUp]):
	for i in powerUpSelectors.size():
		if (i < receivedPowerUps.size()):
			receivedPowerUps[i].reparent(powerUpSelectors[i].button)
			powerUpSelectors[i].button.text = str(receivedPowerUps[i].powerUpName, "\n", receivedPowerUps[i].powerUpDescription)
			powerUpSelectors[i].show()
			if (receivedPowerUps[i].previousPowerUp != null):
				powerUpSelectors[i].ShowUpgradeLabel(receivedPowerUps[i].previousPowerUp.powerUpName)
			else:
				powerUpSelectors[i].HideUpgradeLabel()
		else :
			powerUpSelectors[i].hide()
	if (receivedPowerUps.size() > 0):
		playerRef.inSelectMenu = true
		get_tree().paused = true
		self.show()

func OnButtonPressed(buttonId: int):
	var selectedPowerUp: PowerUp = powerUpSelectors[buttonId].button.get_child(0)
	selectedPowerUp.reparent(playerRef.powerUpManager)
	selectedPowerUp.global_position = playerRef.powerUpManager.global_position
	selectedPowerUp.global_rotation = playerRef.powerUpManager.global_rotation
	selectedPowerUp.powerUpManager = playerRef.powerUpManager
	selectedPowerUp.Register(playerRef)
	rewardSpawn.BanPowerUp(selectedPowerUp)
	if (selectedPowerUp.nextPowerUp != null): rewardSpawn.UnbanPowerUp(selectedPowerUp.nextPowerUp)
	ClearPowerUps()
	playerRef.inSelectMenu = false
	get_tree().paused = false
	self.hide()

func ClearPowerUps():
	for i in powerUpSelectors.size():
		if (powerUpSelectors[i].button.get_child_count() > 0):
			var powerUpToRemove: PowerUp = powerUpSelectors[i].button.get_child(0)
			powerUpToRemove.reparent(playerRef.rewardSpawn)
			powerUpSelectors[i].button.text = ""
