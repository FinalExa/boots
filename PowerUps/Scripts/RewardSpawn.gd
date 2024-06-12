class_name RewardSpawn
extends Node2D

enum RewardType {
	POWERUP
}



@export var powerUpNumber: int
@export var rewardPodiumPath: String
@export var bombRewards: Array[String]
@export var fireRewards: Array[String]
@export var iceRewards: Array[String]

var rewardType: RewardType
var powerUpFaction: PowerUp.PowerUpFaction
var selectedPowerUps: Array[String]

func _ready():
	GeneratePowerUp()

func GenerateRewardType():
	rewardType = RewardType.values().pick_random()
	if (rewardType == RewardType.POWERUP):
		powerUpFaction = PowerUp.PowerUpFaction.values().pick_random()

func SpawnReward():
	call_deferred("GeneratePodium")

func GeneratePowerUp():
	if (rewardType == RewardType.POWERUP):
		if (powerUpFaction == PowerUp.PowerUpFaction.BOMB):
			selectedPowerUps = SetupRewardArray(bombRewards)

func SetupRewardArray(receivedArray: Array[String]):
	var rewardArray: Array[String] = receivedArray
	var selectedArray: Array[String]
	var randomIndex: int
	for i in powerUpNumber:
		if (rewardArray.size() > 0):
			randomIndex = randi_range(0, rewardArray.size() - 1)
			selectedArray.push_back(rewardArray[randomIndex])
			rewardArray.remove_at(randomIndex)
	return selectedArray

func GeneratePodium():
	var obj_scene = load(rewardPodiumPath)
	var obj = obj_scene.instantiate()
	add_child(obj)
	obj.global_position = self.global_position
	obj.ReceiveRewards(rewardType, powerUpFaction, selectedPowerUps)
	obj.SpawnRewards()
