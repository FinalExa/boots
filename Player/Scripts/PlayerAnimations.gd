extends AnimatedSprite2D

@export var isHub: bool
@export var playerMovements: PlayerMovements
@export var playerSpeedThresholds: PlayerSpeedThresholds
@export var playerHubMovement: PlayerHubMovement
@export var stagesFrameSpeed: Array[float]

func _process(_delta):
	SelectCurrentAnimation()

func SelectCurrentAnimation():
	if (!isHub):
		NormalAnimations()
		return
	HubAnimations()

func NormalAnimations():
	if (playerMovements.currentSpeed > 0):
		play("run_front")
		speed_scale = stagesFrameSpeed[playerSpeedThresholds.speedIndex]
		return
	play("idle")
	return

func HubAnimations():
	if (playerHubMovement.currentSpeed > 0):
		play("run_front")
		speed_scale = 1
		return
	play("idle")
	return
