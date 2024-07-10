class_name RewardPodium
extends StaticBody2D

@export var label: Label
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
	label.hide()
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
		call_deferred("DeleteSelf")

func RewardType():
	if (rewardType == RewardSpawn.RewardType.POWERUP):
		playerRef.powerUpUI.RegisterPowerUps(selectedPowerUps)
		return
	if (rewardType == RewardSpawn.RewardType.HEAL):
		playerRef.playerHealth.UpdateHealthValue(healAmount, 0)
		return
	if (rewardType == RewardSpawn.RewardType.MONEY):
		playerRef.UpdateMoney(moneyAmount)

func _on_player_interaction_detect_body_entered(body):
	if (body is PlayerCharacter):
		playerInsideArea = true
		playerRef = body
		label.show()

func _on_player_interaction_detect_body_exited(body):
	if (body is PlayerCharacter):
		playerInsideArea = false
		playerRef = null
		label.hide()

func DeleteSelf():
	get_tree().root.get_child(0).sceneSelector.currentScene.SetCompleted()
	queue_free()
