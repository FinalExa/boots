class_name PowerUp
extends Node2D

enum PowerUpFaction {
	BOMB
}

@export var powerUpName: String
@export var powerUpDescription: String
@export var powerUpFaction: PowerUpFaction

var powerUpManager: PowerUpManager

func ExecutePowerUpEffect():
	pass
