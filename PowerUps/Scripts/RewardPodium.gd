class_name RewardPodium
extends StaticBody2D

@export var label: Label
var rewardSpawnRef: RewardSpawn
var playerInsideArea: bool
var playerRef: PlayerCharacter

var rewardType: RewardSpawn.RewardType
var powerUpFaction: PowerUp.PowerUpFaction
var selectedPowerUps: Array[PowerUp]

func _ready():
	label.hide()

func _process(_delta):
	ListenForPlayerInput()

func ReceiveRewards(type: RewardSpawn.RewardType, faction: PowerUp.PowerUpFaction, powerUps: Array[PowerUp]):
	rewardType = type
	if (rewardType == RewardSpawn.RewardType.POWERUP):
		powerUpFaction = faction
		selectedPowerUps = powerUps

func SpawnRewards():
	for i in selectedPowerUps.size():
		selectedPowerUps[i].reparent(self)

func ListenForPlayerInput():
	if (playerInsideArea && playerRef.playerInputs.interactionInput):
		playerRef.powerUpUI.RegisterPowerUps(selectedPowerUps)
		call_deferred("DeleteSelf")

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
