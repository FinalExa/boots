class_name RewardPodium
extends StaticBody2D

@export var label: Label
var rewardSpawnRef: RewardSpawn
var playerInsideArea: bool
var playerRef: PlayerCharacter

var rewardType: RewardSpawn.RewardType
var powerUpFaction: RewardSpawn.PowerUpFaction
var powerUpNumber: int
var selectedPowerUps: Array[String]

func _ready():
	label.hide()

func _process(delta):
	ListenForPlayerInput()

func ReceiveRewards(type: RewardSpawn.RewardType, faction: RewardSpawn.PowerUpFaction, number: int, powerUps: Array[String]):
	rewardType = type
	if (rewardType == RewardSpawn.RewardType.POWERUP):
		powerUpFaction = faction
		powerUpNumber = number
		selectedPowerUps = powerUps

func ListenForPlayerInput():
	if (playerInsideArea && playerRef.playerInputs.interactionInput):
		print("ciao")

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
