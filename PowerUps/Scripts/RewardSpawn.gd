class_name RewardSpawn
extends Node2D

enum RewardType {
	POWERUP
}

enum PowerUpFaction {
	BOMB,
	FIRE,
	ICE
}

@export var rewardNumber: int
@export var bombRewards: Array[String]
@export var fireRewards: Array[String]
@export var iceRewards: Array[String]

var rewardType: RewardType
var powerUpFaction: PowerUpFaction

func GenerateRewardType():
	rewardType = RewardType.values().pick_random()
	if (rewardType == RewardType.POWERUP):
		powerUpFaction = PowerUpFaction.values().pick_random()

func SpawnReward():
	pass
