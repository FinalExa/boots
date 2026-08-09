class_name Door
extends Node2D

@export var sprite: AnimatedSprite2D
@export var centralCollider: Node2D
@export var endMapArea: String
@export var rewardTypeSprites: Array[Sprite2D]
@export var powerUpFactionSprites: Array[Sprite2D]
var currentScene: GameplayScene
var registered: bool
var rewardSpawnRef: RewardSpawn
var rewardType: RewardSpawn.RewardType
var powerUpFaction: PowerUp.PowerUpFaction

func _ready():
	StartupDoor()
	TurnOffSprites(rewardTypeSprites)
	TurnOffSprites(powerUpFactionSprites)

func StartupDoor():
	var sceneMaster: SceneMaster = get_tree().root.get_child(0)
	currentScene = sceneMaster.sceneSelector.currentScene
	var result: int = currentScene.RegisterDoor(self)
	if (result != -1):
		registered = true
		sprite.play("close")
		rewardSpawnRef = sceneMaster.sceneSelector.rewardSpawn
		if (result == 0):
			GenerateThisDoorReward()
		else:
			GenerateUniqueReward(sceneMaster.sceneSelector.currentScene.doors)

func ForceRewardType(type: RewardSpawn.RewardType):
	rewardType = type
	if (rewardType == RewardSpawn.RewardType.POWERUP):
		GenerateDoorPowerUpFaction()

func GenerateThisDoorReward():
	GenerateRewardType()
	if (rewardType == RewardSpawn.RewardType.POWERUP):
		GenerateDoorPowerUpFaction()

func GenerateRewardType():
	rewardType = rewardSpawnRef.GetRandomRewardType()

func GenerateDoorPowerUpFaction():
	powerUpFaction = rewardSpawnRef.GetContainer().powerUpFaction
	rewardSpawnRef.powerUpFactionSetByDoor = true

func GenerateDoorPowerUpFactionWithBannedFactions(bannedFactions: Array[PowerUp.PowerUpFaction]):
	powerUpFaction = rewardSpawnRef.GetContainerWithBannedContainers(bannedFactions)
	rewardSpawnRef.powerUpFactionSetByDoor = true

func GenerateUniqueReward(otherDoors: Array[Door]):
	var bannedRewardTypes: Array[RewardSpawn.RewardType] = []
	var bannedFactions: Array[PowerUp.PowerUpFaction] = []
	for i in otherDoors.size() - 1:
		if (otherDoors[i].rewardType != RewardSpawn.RewardType.POWERUP):
			bannedRewardTypes.push_back(otherDoors[i].rewardType)
			continue
		if (!bannedRewardTypes.has(RewardSpawn.RewardType.POWERUP)):
			bannedFactions.push_back(otherDoors[i].powerUpFaction)
			if (bannedFactions.size() == rewardSpawnRef.powerUpContainers.size()):
				bannedRewardTypes.push_back(RewardSpawn.RewardType.POWERUP)
	while (bannedRewardTypes.size() > 0 && bannedRewardTypes.has(rewardType)):
		GenerateRewardType()
	if (rewardType == RewardSpawn.RewardType.POWERUP):
		GenerateDoorPowerUpFactionWithBannedFactions(bannedFactions)
		if (powerUpFaction == -1):
			bannedRewardTypes.push_back(RewardSpawn.RewardType.POWERUP)
			while (bannedRewardTypes.size() > 0 && bannedRewardTypes.has(rewardType)):
				GenerateRewardType()

func OpenDoor():
	if (registered):
		sprite.play("open")
		ActivateCurrentRewardSprite()
		centralCollider.queue_free()
		var obj_scene = load(endMapArea)
		var obj: EndMapArea = obj_scene.instantiate()
		add_child(obj)
		obj.doorRef = self

func ActivateCurrentRewardSprite():
	if (rewardType != RewardSpawn.RewardType.POWERUP):
		rewardTypeSprites[rewardType].show()
		return
	powerUpFactionSprites[powerUpFaction].show()

func TurnOffSprites(arrayToTurnOff: Array[Sprite2D]):
	for i in arrayToTurnOff.size():
		if (arrayToTurnOff[i] != null):
			arrayToTurnOff[i].hide()
