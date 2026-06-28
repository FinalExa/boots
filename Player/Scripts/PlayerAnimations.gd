extends AnimatedSprite2D

@export var playerMovements: PlayerMovements
@export var playerSpeedThresholds: PlayerSpeedThresholds
@export var stagesFrameSpeed: Array[float]
@export var isHub: bool
@export var playerHubMovement: PlayerHubMovement

func _process(_delta):
	SelectCurrentAnimation()

func SelectCurrentAnimation():
	if (!isHub):
		NormalAnimations()
		return
	HubAnimations()

func NormalAnimations():
	if (playerMovements.currentSpeed > 0):
		SetCorrectAnimation(playerMovements.currentDirection)
		speed_scale = stagesFrameSpeed[playerSpeedThresholds.speedIndex]
		return
	play("idle")
	return

func HubAnimations():
	if (playerHubMovement.currentSpeed > 0):
		SetCorrectAnimation(playerHubMovement.playerHubRef.playerInputs.movementInput)
		speed_scale = 1
		return
	play("idle")
	return

func SetCorrectAnimation(direction: Vector2):
	if (abs(direction.x) > 0 && abs(direction.y) > 0):
		if (abs(direction.x) >= abs(direction.y)):
			HorizontalAnimations(direction.x)
			return
		VerticalAnimations(direction.y)
	if (direction.y == 0 && direction.x != 0):
		HorizontalAnimations(direction.x)
		return
	if (direction.x == 0 && direction.y != 0):
		VerticalAnimations(direction.y)
		return

func HorizontalAnimations(xValue: float):
	if (xValue >= 0):
		play("run_right")
		return
	play("run_left")

func VerticalAnimations(yValue: float):
	if (yValue >= 0):
		play("run_down")
		return
	play("run_up")
