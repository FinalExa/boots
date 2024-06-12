class_name RewardPodium
extends StaticBody2D

@export var label: Label
var rewardSpawnRef: RewardSpawn
var playerInsideArea: bool
var playerRef: PlayerCharacter

var rewardType: RewardSpawn.RewardType
var powerUpFaction: PowerUp.PowerUpFaction
var selectedPowerUps: Array[String]
var generatedPowerUps: Array[PowerUp]

func _ready():
	label.hide()

func _process(_delta):
	ListenForPlayerInput()

func ReceiveRewards(type: RewardSpawn.RewardType, faction: PowerUp.PowerUpFaction, powerUps: Array[String]):
	rewardType = type
	if (rewardType == RewardSpawn.RewardType.POWERUP):
		powerUpFaction = faction
		selectedPowerUps = powerUps

func SpawnRewards():
	for i in selectedPowerUps.size():
		var obj_scene = load(selectedPowerUps[i])
		var obj = obj_scene.instantiate()
		generatedPowerUps.push_back(obj)
		add_child(obj)

func ListenForPlayerInput():
	if (playerInsideArea && playerRef.playerInputs.interactionInput):
		playerRef.powerUpUI.RegisterPowerUps(generatedPowerUps)

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
