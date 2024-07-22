class_name Door
extends Node2D

@export var activeSprite: Sprite2D
@export var offSprite: Sprite2D
@export var centralCollider: Node2D
@export var endMapArea: String
@export var rewardTypeSprites: Array[Sprite2D]
@export var powerUpFactionSprites: Array[Sprite2D]
var rewardSpawnRef: RewardSpawn
var rewardType: RewardSpawn.RewardType
var powerUpFaction: PowerUp.PowerUpFaction

func _ready():
	StartupDoor()
	TurnOffSprites(rewardTypeSprites)
	TurnOffSprites(powerUpFactionSprites)

func StartupDoor():
	offSprite.hide()
	var sceneMaster: SceneMaster = get_tree().root.get_child(0)
	sceneMaster.sceneSelector.currentScene.RegisterDoor(self)
	rewardSpawnRef = sceneMaster.sceneSelector.rewardSpawn
	GenerateThisDoorReward()

func GenerateThisDoorReward():
	rewardType = rewardSpawnRef.GetRandomRewardType()
	if (rewardType == RewardSpawn.RewardType.POWERUP):
		powerUpFaction = rewardSpawnRef.GetRandomPowerUpFaction()

func OpenDoor():
	offSprite.show()
	activeSprite.hide()
	ActivateCurrentRewardSprite()
	remove_child(centralCollider)
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
