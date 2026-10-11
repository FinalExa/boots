class_name PowerUpContainer
extends Node2D

@export var powerUpFaction: PowerUp.PowerUpFaction
@export var powerUps: Array[PowerUp]
@export var bannedPowerUps: Array[PowerUp]
@export var forceAtStart: Array[PowerUp]

func _ready():
	if (forceAtStart.size() > 0):
		var playerRef: PlayerCharacter = get_tree().root.get_child(0).sceneSelector.playerRef
		for i in forceAtStart.size():
			if (forceAtStart[i] != null):
				forceAtStart[i].Register(playerRef)

func BanPowerUp(receivedPowerUp: PowerUp):
	bannedPowerUps.push_back(receivedPowerUp)

func UnbanPowerUp(receivedPowerUp: PowerUp):
	receivedPowerUp.reparent(self)
	bannedPowerUps.erase(receivedPowerUp)
