class_name PowerUpContainer
extends Node2D

@export var powerUpFaction: PowerUp.PowerUpFaction
@export var powerUps: Array[PowerUp]
@export var bannedPowerUps: Array[PowerUp]

func BanPowerUp(receivedPowerUp: PowerUp):
	bannedPowerUps.push_back(receivedPowerUp)

func UnbanPowerUp(receivedPowerUp: PowerUp):
	receivedPowerUp.reparent(self)
	bannedPowerUps.erase(receivedPowerUp)
