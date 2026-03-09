class_name RewardPodium
extends StaticBody2D

@export var inputIcon: AnimatedSprite2D
@export var sprites: Array[Sprite2D]
@export var healAmount: float
@export var moneyAmount: float
var rewardSpawnRef: RewardSpawn
var playerInsideArea: bool
var playerRef: PlayerCharacter

var rewardType: RewardSpawn.RewardType
var powerUpFaction: PowerUp.PowerUpFaction
var selectedPowerUps: Array[PowerUp]

func _ready():
	inputIcon.hide()
	TurnOffSprites()

func TurnOffSprites():
	for i in sprites.size():
		sprites[i].hide()

func _process(_delta):
	ListenForPlayerInput()

func ReceiveRewards(type: RewardSpawn.RewardType, faction: PowerUp.PowerUpFaction, powerUps: Array[PowerUp]):
	sprites[type].show()
	rewardType = type
	if (rewardType == RewardSpawn.RewardType.POWERUP):
		powerUpFaction = faction
		selectedPowerUps = powerUps

func SpawnRewards():
	for i in selectedPowerUps.size():
		selectedPowerUps[i].reparent(self)

func ListenForPlayerInput():
	if (playerInsideArea && playerRef.playerInputs.interactionInput):
		RewardType()

func RewardType():
	if (rewardType == RewardSpawn.RewardType.POWERUP):
		playerRef.powerUpUI.RegisterPowerUps(selectedPowerUps)
		call_deferred("DeleteSelf")
		return
	if (rewardType == RewardSpawn.RewardType.HEAL):
		playerRef.playerHealth.UpdateHealthValue(healAmount, 0)
		call_deferred("DeleteSelf")
		return
	if (rewardType == RewardSpawn.RewardType.MONEY):
		playerRef.UpdateMoney(moneyAmount)
		call_deferred("DeleteSelf")
		return
	if (rewardType == RewardSpawn.RewardType.SHOP):
		var rewardSpawnLocation: Node2D = self.get_parent().get_parent()
		self.reparent(rewardSpawnLocation)
		get_tree().root.get_child(0).sceneSelector.playerRef.shopUI.SetUpShop(get_tree().root.get_child(0).sceneSelector.rewardSpawn)
		call_deferred("DeleteSelf")

func _on_player_interaction_detect_body_entered(body):
	if (body is PlayerCharacter):
		playerInsideArea = true
		playerRef = body
		inputIcon.show()

func _on_player_interaction_detect_body_exited(body):
	if (body is PlayerCharacter):
		playerInsideArea = false
		playerRef = null
		inputIcon.hide()

func DeleteSelf():
	get_tree().root.get_child(0).sceneSelector.currentScene.SetCompleted()
	queue_free()
