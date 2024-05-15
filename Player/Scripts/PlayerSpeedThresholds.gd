class_name PlayerSpeedThresholds
extends Node2D

@export var playerMovements: PlayerMovements
@export var speedThresholds: Array[float]
var speedIndex: int

func _ready():
	speedIndex = 0

func _process(_delta):
	SetCurrentSpeedThreshold()

func SetCurrentSpeedThreshold():
	if (playerMovements.currentSpeed > 0):
		SetSpeedLevel()
	else:
		speedIndex = 0

func SetSpeedLevel():
	SetHigherSpeedLevel()
	SetLowerSpeedLevel()

func SetHigherSpeedLevel():
	if (speedIndex < speedThresholds.size() - 1 && playerMovements.currentSpeed >= speedThresholds[speedIndex]):
		speedIndex += 1
		print(str("Current speed level: ", speedIndex))

func SetLowerSpeedLevel():
	if (speedIndex > 0 && playerMovements.currentSpeed < speedThresholds[speedIndex - 1]):
		speedIndex -= 1
		print(str("Current speed level: ", speedIndex))
