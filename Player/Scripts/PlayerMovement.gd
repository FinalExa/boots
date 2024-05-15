class_name PlayerMovements
extends Node

@export var playerBody: CharacterBody2D
@export var playerInputs: PlayerInputs

@export var accelerationPerSecond: float
@export var decelerationPerSecond: float
@export var rotationSpeedPerSecond: float
@export var minSpeed: float
@export var maxSpeed: float
var currentSpeed: float
var currentDirection: Vector2
var xValue: float
var yValue: float

func _ready():
	currentSpeed = 0

func SetCurrentSpeed(delta):
	if (playerInputs.movementInput == Vector2.ZERO):
		currentSpeed -= decelerationPerSecond * delta
		if (currentSpeed == 0):
			currentDirection = Vector2.ZERO
	else:
		currentSpeed = clamp(currentSpeed + (accelerationPerSecond * delta), minSpeed, maxSpeed)
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
	currentDirection.x = SetDirectionValue(playerInputs.movementInput.x, currentDirection.x, xValue, delta)
	currentDirection.y = SetDirectionValue(playerInputs.movementInput.y, currentDirection.y, yValue, delta)

func SetDirectionValue(movementValue: float, directionValue: float, value: int, delta):
	var minValue: float
	var maxValue: float
	if (value == -1):
		minValue = movementValue
		maxValue = 1
	else:
		minValue = -1
		maxValue = movementValue
	return clamp(directionValue + (value * rotationSpeedPerSecond * delta), minValue, maxValue)

func CalculateRotationDirection():
	if (currentDirection.x > playerInputs.movementInput.x): xValue = -1
	else: xValue = 1
	if (currentDirection.y > playerInputs.movementInput.y): yValue = -1
	else: yValue = 1

func _physics_process(delta):
	SetCurrentSpeed(delta)
	playerBody.move_and_slide()
