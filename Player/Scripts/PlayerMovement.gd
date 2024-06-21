class_name PlayerMovements
extends Node

@export var playerCharacter: PlayerCharacter
@export var playerInputs: PlayerInputs

@export var maxAccelerationPerSecond: float
@export var maxAccelerationPerSecondEndPoint: float
@export var minAccelerationPerSecond: float
@export var minAccelerationPerSecondEndPoint: float
@export var decelerationPerSecond: float
@export var decelerationWhileColliding: float
@export var minDecelerationWhileSteering: float
@export var maxDecelerationWhileSteering: float
@export var decelerationWhileSteeringRequiredSpeed: float
@export var decelerationWhileSteeringIncreasePerSecond: float
@export var decelerationWhileSteeringDecreasePerSecond: float
@export var rotationSpeedPerSecond: float
@export var killSpeedValue: float
@export var minSpeed: float
@export var maxSpeed: float
var currentAcceleration: float
var accelerationMultiplier: float
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
	accelerationMultiplier = (maxAccelerationPerSecond - minAccelerationPerSecond) / (minAccelerationPerSecondEndPoint - maxAccelerationPerSecondEndPoint)
	lastDirection = Vector2.ZERO

func _process(delta):
	SetCurrentAcceleration()
	SetCurrentSpeed(delta)
	DecelerationWhileSteering(delta)

func _physics_process(_delta):
	MovePlayerCharacter()

func SetCurrentAcceleration():
	if (currentSpeed < maxAccelerationPerSecondEndPoint):
		currentAcceleration = maxAccelerationPerSecond
		return
	if (currentSpeed > minAccelerationPerSecondEndPoint):
		currentAcceleration = minAccelerationPerSecond
		return
	currentAcceleration = maxAccelerationPerSecond - ((currentSpeed - maxAccelerationPerSecondEndPoint) * accelerationMultiplier)

func SetCurrentSpeed(delta):
	if (playerInputs.movementInput == Vector2.ZERO):
		if (decelerationWhileSteeringActive): decelerationWhileSteeringActive = false
		Decelerate(delta, decelerationPerSecond)
		if (currentSpeed <= minSpeed):
			currentSpeed = 0
		if (currentSpeed == 0):
			currentDirection = Vector2.ZERO
	else:
		SetDirection(delta)
		AccelerationCases(delta)
	currentSpeed = clamp(currentSpeed, 0, maxSpeed)

func MovePlayerCharacter():
	playerCharacter.velocity = currentDirection * currentSpeed

func AccelerationCases(delta):
	if (playerCharacter.collisionResult):
		currentSpeed -= decelerationWhileColliding * delta
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
	currentSpeed = clamp(currentSpeed + (currentAcceleration * delta), minSpeed, maxSpeed)

func Decelerate(delta, decelerationValue):
	currentSpeed = clamp(currentSpeed - (decelerationValue * delta), minSpeed, maxSpeed)

func UpdateCurrentSpeed(updateValue):
	currentSpeed = clamp(currentSpeed + updateValue, 0, maxSpeed)

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
		currentDirection = SetNewDirection(delta)
		if (lastDirection != currentDirection): directionDifferent = true
		else: directionDifferent = false
		lastDirection = currentDirection

func SetNewDirection(delta):
	var x: float = SetDirectionValue(playerInputs.movementInput.x, currentDirection.x, xValue, delta)
	var y: float = SetDirectionValue(playerInputs.movementInput.y, currentDirection.y, yValue, delta)
	return Vector2(x, y)

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

func SetToZero():
	currentSpeed = 0
	playerCharacter.velocity = Vector2.ZERO
	playerCharacter.playerSpeedThresholds.Startup()
