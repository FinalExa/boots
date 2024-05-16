class_name PlayerMovements
extends Node

@export var playerCharacter: PlayerCharacter
@export var playerBody: CharacterBody2D
@export var playerInputs: PlayerInputs

@export var accelerationPerSecond: float
@export var decelerationPerSecond: float
@export var decelerationWhileColliding: float
@export var minDecelerationWhileSteering: float
@export var maxDecelerationWhileSteering: float
@export var decelerationWhileSteeringRequiredSpeed: float
@export var decelerationWhileSteeringIncreasePerSecond: float
@export var decelerationWhileSteeringDecreasePerSecond: float
@export var rotationSpeedPerSecond: float
@export var minSpeed: float
@export var maxSpeed: float
var currentDecelerationWhileSteering: float
var decelerationWhileSteeringActive: bool
var currentSpeed: float
var currentDirection: Vector2
var lastDirection: Vector2
var directionDifferent: bool
var xValue: float
var yValue: float

func _ready():
	currentSpeed = 0
	currentDecelerationWhileSteering = minDecelerationWhileSteering
	lastDirection = Vector2.ZERO

func _process(delta):
	DecelerationWhileSteering(delta)

func _physics_process(delta):
	SetCurrentSpeed(delta)

func SetCurrentSpeed(delta):
	if (playerInputs.movementInput == Vector2.ZERO):
		if (decelerationWhileSteeringActive): decelerationWhileSteeringActive = false
		Decelerate(delta, decelerationPerSecond)
		if (currentSpeed < minSpeed):
			currentSpeed = 0
		if (currentSpeed == 0):
			currentDirection = Vector2.ZERO
	else:
		SetDirection(delta)
		AccelerationCases(delta)
	currentSpeed = clamp(currentSpeed, 0, maxSpeed)
	playerBody.velocity = currentDirection * currentSpeed

func AccelerationCases(delta):
	if (playerCharacter.collisionResult):
		Decelerate(delta, decelerationWhileColliding)
		return
	if (!directionDifferent):
		Accelerate(delta)
		if (decelerationWhileSteeringActive): decelerationWhileSteeringActive = false
		return
	if (currentSpeed >= decelerationWhileSteeringRequiredSpeed):
		if (!decelerationWhileSteeringActive): decelerationWhileSteeringActive = true
		Decelerate(delta, currentDecelerationWhileSteering)
		return
	Accelerate(delta)

func Accelerate(delta):
	currentSpeed = clamp(currentSpeed + (accelerationPerSecond * delta), minSpeed, maxSpeed)

func Decelerate(delta, decelerationValue):
	currentSpeed = clamp(currentSpeed - (decelerationValue * delta), minSpeed, maxSpeed)

func DecelerationWhileSteering(delta):
	if (decelerationWhileSteeringActive):
		currentDecelerationWhileSteering = clamp(currentDecelerationWhileSteering + (decelerationWhileSteeringIncreasePerSecond * delta), minDecelerationWhileSteering, maxDecelerationWhileSteering)
	else:
		if (currentDecelerationWhileSteering != minDecelerationWhileSteering):
			currentDecelerationWhileSteering = clamp(currentDecelerationWhileSteering - (decelerationWhileSteeringDecreasePerSecond * delta), minDecelerationWhileSteering, maxDecelerationWhileSteering)

func SetDirection(delta):
	if (currentDirection == Vector2.ZERO):
		currentDirection = playerInputs.movementInput
	else:
		CalculateRotationDirection()
		SetNewDirection(delta)
		if (lastDirection != currentDirection): directionDifferent = true
		else: directionDifferent = false
		lastDirection = currentDirection

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
