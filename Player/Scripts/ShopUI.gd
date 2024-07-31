class_name ShopUI
extends Control

@export var playerRef: PlayerCharacter
@export var powerUpButton: Button
@export var powerUpPrice: float
var powerUpRef: PowerUp
var powerUpBought: bool
@export var healingButton: Button
@export var healingValue: float
@export var healingPrice: float
var healingBought: bool

func _ready():
	self.hide()

func SetUpShop(rewardSpawnRef: RewardSpawn):
	var tempPowerUpArray: Array[PowerUp] = rewardSpawnRef.GenerateRewardArrayWithoutBannedPowerUps(rewardSpawnRef.powerUps)
	if (tempPowerUpArray.size() > 0):
		powerUpRef = tempPowerUpArray.pick_random()
		powerUpButton.text = str(powerUpRef.powerUpName, "\n", powerUpRef.powerUpDescription, "\n", "Price: ", powerUpPrice, " Ectocrystals")
		powerUpButton.get_parent().show()
		powerUpBought = false
	else:
		powerUpBought = true
		powerUpButton.get_parent().hide()
	if (playerRef.playerHealth.currentHealth < playerRef.playerHealth.maxHealth):
		healingButton.text = str("Recover ", healingValue, " integrity.", "\n", "Price: ", healingPrice, " Ectocrystals")
		healingButton.get_parent().show()
		healingBought = false
	else:
		healingBought = true
		healingButton.get_parent().hide()
	get_tree().paused = true
	self.show()
	CheckIfShopIsAvailable()

func PowerUpButtonPressed():
	if (!powerUpBought && playerRef.currentMoney >= powerUpPrice):
		powerUpRef.reparent(playerRef.powerUpManager)
		powerUpRef.global_position = playerRef.powerUpManager.global_position
		powerUpRef.global_rotation = playerRef.powerUpManager.global_rotation
		powerUpRef.powerUpManager = playerRef.powerUpManager
		powerUpRef.Register()
		playerRef.rewardSpawn.BanPowerUp(powerUpRef)
		playerRef.UpdateMoney(-powerUpPrice)
		powerUpBought = true
		powerUpButton.get_parent().hide()
		CheckIfShopIsAvailable()

func HealingButtonPressed():
	if (!healingBought && playerRef.currentMoney >= healingPrice):
		playerRef.playerHealth.UpdateHealthValue(healingValue, 0)
		playerRef.UpdateMoney(-powerUpPrice)
		healingBought = true
		healingButton.get_parent().hide()
		CheckIfShopIsAvailable()

func CheckIfShopIsAvailable():
	if (healingBought && powerUpBought):
		BackButtonPressed()

func BackButtonPressed():
	get_tree().paused = false
	self.hide()
