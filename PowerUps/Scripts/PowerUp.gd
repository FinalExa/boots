class_name PowerUp
extends Node2D

enum PowerUpFaction {
	BOMB
}

enum PowerUpType {
	CONTACT,
	DOWN_SWITCH,
	UP_SWITCH,
	SPEED_CHARGE,
	TRAIL,
	PASSIVE
}

@export var powerUpName: String
@export var powerUpDescription: String
@export var powerUpFaction: PowerUpFaction
@export var powerUpType: PowerUpType

var powerUpManager: PowerUpManager

func _ready():
	Register()

func Register():
	powerUpManager.AssignPowerUp(self)

func ExecutePowerUpEffect():
	pass

func SecondaryExecutePowerUpEffect():
	pass

func ExecutePowerUpEffectWithValue(value):
	pass
