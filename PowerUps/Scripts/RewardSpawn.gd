class_name RewardSpawn
extends Node2D

enum RewardType {
	POWERUP
}

@export var powerUpNumber: int
@export var rewardPodiumPath: String
@export var powerUps: Array[PowerUp]

var rewardType: RewardType
var powerUpFaction: PowerUp.PowerUpFaction
var selectedPowerUps: Array[PowerUp]
var bannedPowerUps: Array[PowerUp]

func GenerateRewardType():
	rewardType = RewardType.values().pick_random()
	if (rewardType == RewardType.POWERUP):
		powerUpFaction = PowerUp.PowerUpFaction.values().pick_random()
		GeneratePowerUp()

func SpawnReward():
	call_deferred("GeneratePodium")

func GeneratePowerUp():
	if (rewardType == RewardType.POWERUP):
		if (powerUpFaction == PowerUp.PowerUpFaction.BOMB):
			selectedPowerUps = SetupRewardArray(powerUps)

func SetupRewardArray(receivedArray: Array[PowerUp]):
	var rewardArray: Array[PowerUp] = GenerateRewardArrayWithoutBannedPowerUps(receivedArray)
	var selectedArray: Array[PowerUp] = []
	var randomIndex: int
	for i in powerUpNumber:
		if (rewardArray.size() > 0):
			randomIndex = randi_range(0, rewardArray.size() - 1)
			selectedArray.push_back(rewardArray[randomIndex])
			rewardArray.remove_at(randomIndex)
	return selectedArray

func GenerateRewardArrayWithoutBannedPowerUps(receivedArray: Array[PowerUp]):
	var rewardArray: Array[PowerUp] = []
	for i in receivedArray.size():
		if (!bannedPowerUps.has(receivedArray[i])):
			rewardArray.push_back(receivedArray[i])
	return rewardArray

func BanPowerUp(receivedPowerUp: PowerUp):
	bannedPowerUps.push_back(receivedPowerUp)

func UnbanPowerUp(receivedPowerUp: PowerUp):
	bannedPowerUps.erase(receivedPowerUp)

func GeneratePodium():
	var obj_scene = load(rewardPodiumPath)
	var podium: RewardPodium = obj_scene.instantiate()
	add_child(podium)
	podium.global_position = self.global_position
	podium.ReceiveRewards(rewardType, powerUpFaction, selectedPowerUps)
	podium.SpawnRewards()
