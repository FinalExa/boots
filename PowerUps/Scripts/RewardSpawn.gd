class_name RewardSpawn
extends Node2D

enum RewardType {
	POWERUP,
	HEAL,
	MONEY,
	SHOP
}

@export var powerUpNumber: int
@export var rewardPodiumPath: String
@export var powerUpContainers: Array[PowerUpContainer]
@export var rewardTypes: Array[RewardType]
@export var rewardChances: Array[int]
@export var firstRoomChances: Array[int]
@export var playerRef: PlayerCharacter

var roomNumber: int
var maxChance: int
var powerUpFactionSetByDoor: bool
var rewardType: RewardType
var powerUpFaction: PowerUp.PowerUpFaction
var selectedPowerUps: Array[PowerUp]
var bannedPowerUps: Array[PowerUp]

func _ready():
	CalculateMaxChance()
	roomNumber = 0

func CalculateMaxChance():
	maxChance = 0
	for i in rewardChances.size():
		maxChance += rewardChances[i]

func GenerateRewardType():
	if (roomNumber == 0):
		rewardType = GetRandomRewardType()
		if (rewardType == RewardType.POWERUP):
			GeneratePowerUp()
	roomNumber += 1

func AssignRewardType(receivedType: RewardType, receivedFaction: PowerUp.PowerUpFaction):
	rewardType = receivedType
	powerUpFaction = receivedFaction
	GeneratePowerUp()

func GetRandomRewardType():
	var arrayToUse: Array[int] = rewardChances
	if (roomNumber == 0):
		arrayToUse = firstRoomChances
	return rewardTypes[SelectRewardType(arrayToUse)]

func SelectRewardType(arrayToUse: Array[int]):
	var randomNumber: int = randi_range(1, maxChance)
	var currentRange: int = 0
	var savedInt: int = 0
	for i in arrayToUse.size():
		if (randomNumber > currentRange && randomNumber <= currentRange + arrayToUse[i]):
			savedInt = i
			break
		currentRange += arrayToUse[i]
	return savedInt

func SpawnReward():
	call_deferred("GeneratePodium")

func GeneratePowerUp():
	selectedPowerUps = SetupRewardArray(GetContainer())

func GetContainer():
	var validContainers: Array[PowerUpContainer] = []
	for i in powerUpContainers.size():
		if (powerUpContainers[i].powerUps.size() > powerUpContainers[i].bannedPowerUps.size()):
			validContainers.push_back(powerUpContainers[i])
	if (!powerUpFactionSetByDoor):
		powerUpFaction = validContainers[randi_range(0, validContainers.size() - 1)].powerUpFaction
	for i in validContainers.size():
		if (validContainers[i].powerUpFaction == powerUpFaction):
			powerUpFactionSetByDoor = false
			return validContainers[powerUpFaction]

func SetupRewardArray(receivedContainer: PowerUpContainer):
	var rewardArray: Array[PowerUp] = GenerateRewardArrayWithoutBannedPowerUps(receivedContainer)
	var selectedArray: Array[PowerUp] = []
	var randomIndex: int
	for i in powerUpNumber:
		if (rewardArray.size() > 0):
			randomIndex = randi_range(0, rewardArray.size() - 1)
			selectedArray.push_back(rewardArray[randomIndex])
			rewardArray.remove_at(randomIndex)
	return selectedArray

func GenerateRewardArrayWithoutBannedPowerUps(container: PowerUpContainer):
	var rewardArray: Array[PowerUp] = []
	var hasBase: bool = playerRef.powerUpManager.PlayerHasAnyBasePowerUpOfFaction(powerUpFaction)
	for i in container.powerUps.size():
		if (!container.bannedPowerUps.has(container.powerUps[i]) && container.powerUpFaction == powerUpFaction):
			if (hasBase || (!hasBase && !(container.powerUps[i] is PassivePowerUp))):
				rewardArray.push_back(container.powerUps[i])
	return rewardArray

func GeneratePodium():
	var obj_scene = load(rewardPodiumPath)
	var podium: RewardPodium = obj_scene.instantiate()
	add_child(podium)
	podium.global_position = self.global_position
	podium.ReceiveRewards(rewardType, powerUpFaction, selectedPowerUps)
	podium.SpawnRewards()

func BanPowerUp(powerUp: PowerUp):
	powerUpContainers[powerUp.powerUpFaction].BanPowerUp(powerUp)

func UnbanPowerUp(powerUp: PowerUp):
	powerUpContainers[powerUp.powerUpFaction].UnbanPowerUp(powerUp)
