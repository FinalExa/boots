class_name Door
extends Node2D

@export var sprite: AnimatedSprite2D
@export var centralCollider: Node2D
@export var endMapArea: String
@export var rewardTypeSprites: Array[Sprite2D]
@export var powerUpFactionSprites: Array[Sprite2D]
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
	var result: int = sceneMaster.sceneSelector.currentScene.RegisterDoor(self)
	if (result != -1):
		registered = true
		sprite.play("close")
		rewardSpawnRef = sceneMaster.sceneSelector.rewardSpawn
		if (result == 0):
			GenerateThisDoorReward()
		else:
			GenerateUniqueReward(sceneMaster.sceneSelector.currentScene.doors)

func GenerateThisDoorReward():
	rewardType = rewardSpawnRef.GetRandomRewardType()
	if (rewardType == RewardSpawn.RewardType.POWERUP):
		powerUpFaction = rewardSpawnRef.GetRandomPowerUpFaction()

func GenerateUniqueReward(otherDoors: Array[Door]):
	var bannedRewardTypes: Array[RewardSpawn.RewardType] = []
	for i in otherDoors.size() - 1:
		bannedRewardTypes.push_back(otherDoors[i].rewardType)
	GenerateThisDoorReward()
	while (bannedRewardTypes.has(rewardType)):
		GenerateThisDoorReward()

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
