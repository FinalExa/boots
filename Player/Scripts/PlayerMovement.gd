class_name PlayerMovements
extends Node

@export var playerBody: CharacterBody2D
@export var playerInputs: PlayerInputs

@export var accelerationPerSecond: float
@export var decelerationPerSecond: float
@export var rotationSpeedPerSecond: float
@export var maxSpeed: float
var currentSpeed: float
var currentDirection: Vector2
var xValue: float
var yValue: float

func _ready():
	currentSpeed = 0

func SetCurrentSpeed(delta):
	if (playerInputs.movementInput == Vector2.ZERO):
		currentSpeed-=decelerationPerSecond*delta
		if (currentSpeed == 0):
			currentDirection = Vector2.ZERO
	else:
		currentSpeed+=accelerationPerSecond*delta
		SetDirection(delta)
	currentSpeed = clamp(currentSpeed, 0, maxSpeed)
	playerBody.velocity = currentDirection * currentSpeed
	
func SetDirection(delta):
	if (currentDirection == Vector2.ZERO):
		currentDirection = playerInputs.movementInput
	else:
		CalculateRotationDirection()
		SetNewDirection(delta)

func SetNewDirection(delta):
	var minXValue: float
	var maxXValue: float
	if (xValue == -1):
		minXValue = playerInputs.movementInput.x
		maxXValue = 1
	else:
		minXValue = -1
		maxXValue = playerInputs.movementInput.x
	currentDirection.x = clamp(currentDirection.x+(xValue*rotationSpeedPerSecond*delta), minXValue, maxXValue)
	var minYValue
	var maxYValue
	if (yValue == -1):
		minYValue = playerInputs.movementInput.y
		maxYValue = 1
	else:
		minYValue = -1
		maxYValue = playerInputs.movementInput.y
	currentDirection.y = clamp(currentDirection.y+(yValue*rotationSpeedPerSecond*delta), minYValue, maxYValue)

func CalculateRotationDirection():
	if (currentDirection.x > playerInputs.movementInput.x): xValue = -1
	else: xValue = 1
	if (currentDirection.y > playerInputs.movementInput.y): yValue = -1
	else: yValue = 1

func _physics_process(delta):
	SetCurrentSpeed(delta)
	playerBody.move_and_slide()
