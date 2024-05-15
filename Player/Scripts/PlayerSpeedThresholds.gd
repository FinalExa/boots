class_name PlayerSpeedThresholds
extends Node2D

@export var playerMovements: PlayerMovements
@export var speedThresholds: Array[float]
@export var thresholdHitboxes: Array[Area2D]
var speedIndex: int

func _ready():
	Startup()

func _process(_delta):
	SetCurrentSpeedThreshold()

func Startup():
	speedIndex = 0
	for i in thresholdHitboxes.size():
		DectivateCurrentHitbox(i)

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
		DectivateCurrentHitbox(speedIndex)
		speedIndex += 1
		ActivateCurrentHitbox(speedIndex)

func SetLowerSpeedLevel():
	if (speedIndex > 0 && playerMovements.currentSpeed < speedThresholds[speedIndex - 1]):
		DectivateCurrentHitbox(speedIndex)
		speedIndex -= 1
		ActivateCurrentHitbox(speedIndex)

func DectivateCurrentHitbox(index: int):
	if (thresholdHitboxes[index] != null): 
		thresholdHitboxes[index].hide()

func ActivateCurrentHitbox(index: int):
	if (thresholdHitboxes[index] != null):
		thresholdHitboxes[speedIndex].show()
