class_name PlayerMovements
extends Node

@export var playerCharacter: PlayerCharacter
@export var playerInputs: PlayerInputs

@export var maxAccelerationPerSecond: float
@export var maxAccelerationPerSecondEndPoint: float
@export var minAccelerationPerSecond: float
@export var minAccelerationPerSecondEndPoint: float
@export var decelerationPerSecond: float
@export var decelerationDecreaseOnCollision: float
@export var minDecelerationWhileSteering: float
@export var maxDecelerationWhileSteering: float
@export var decelerationWhileSteeringRequiredSpeed: float
@export var decelerationWhileSteeringIncreasePerSecond: float
@export var decelerationWhileSteeringDecreasePerSecond: float
@export var rotationSpeedPerSecond: float
@export var killSpeedValue: float
@export var minSpeed: float
@export var maxSpeed: float
@export var distanceDifferenceTolerance: float
@export var distanceDifferenceToleranceMinSpeed: float
@export var decelerationForDistanceDifference: float
@export var currentDirectionWeight: int = 1
var currentAcceleration: float
var accelerationMultiplier: float
var currentDecelerationWhileSteering: float
var decelerationWhileSteeringActive: bool
var currentSpeed: float
var currentDirection: Vector2
var lastDirection: Vector2
var lastPosition: Vector2
var distanceToLastPos: float
var directionDifferent: bool
var decelerating: bool
var effectiveDeceleration: float
var xValue: float
var yValue: float
var speedModifiers: Array[SpeedModifier]
var finalSpeedModifier: float
var enforcedDirections: Array[Vector2]

func _ready():
	currentSpeed = 0
	currentDecelerationWhileSteering = minDecelerationWhileSteering
	accelerationMultiplier = (maxAccelerationPerSecond - minAccelerationPerSecond) / (minAccelerationPerSecondEndPoint - maxAccelerationPerSecondEndPoint)
	lastDirection = Vector2.ZERO
	lastPosition = playerCharacter.global_position

func _process(delta):
	SpeedModifiers()
	SetCurrentAcceleration()
	SetCurrentSpeed(delta)
	DecelerationWhileSteering(delta)

func _physics_process(_delta):
	MovePlayerCharacter()

func SetCurrentAcceleration():
	lastPosition = playerCharacter.global_position
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
		Decelerate(delta, decelerationForDistanceDifference)
		if (currentSpeed <= minSpeed):
			currentSpeed = 0
		if (currentSpeed == 0):
			currentDirection = Vector2.ZERO
	else:
		SetDirection(delta)
		AccelerationCases(delta)
	currentSpeed += finalSpeedModifier * delta
	currentSpeed = clamp(currentSpeed, 0, maxSpeed)

func MovePlayerCharacter():
	playerCharacter.velocity = currentDirection * currentSpeed
	distanceToLastPos = lastPosition.distance_to(playerCharacter.global_position)

func AccelerationCases(delta):
	if (distanceToLastPos < distanceDifferenceTolerance && currentSpeed > distanceDifferenceToleranceMinSpeed):
		Decelerate(delta, decelerationPerSecond)
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
	if (decelerating): decelerating = false
	currentSpeed = clamp(currentSpeed + (currentAcceleration * delta), minSpeed, maxSpeed)

func Decelerate(delta, decelerationValue):
	if (!decelerating): decelerating = true
	effectiveDeceleration = decelerationValue
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
	if (enforcedDirections.size() > 0):
		var finalDirection: Vector2 = currentDirection * currentDirectionWeight
		for i in enforcedDirections.size():
			finalDirection += enforcedDirections[i]
		currentDirection = finalDirection / Vector2(enforcedDirections.size() + currentDirectionWeight, enforcedDirections.size() + currentDirectionWeight)

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

func OnCollisionDetected():
	UpdateCurrentSpeed(-decelerationDecreaseOnCollision)

func RegisterSpeedModifier(speedModifier: SpeedModifier):
	if (!speedModifiers.has(speedModifier)):
		speedModifiers.push_front(speedModifier)
		return self
	return null

func UnregisterSpeedModifier(speedModifier: SpeedModifier):
	if (speedModifiers.has(speedModifier)):
		speedModifiers.erase(speedModifier)

func SpeedModifiers():
	finalSpeedModifier = 0
	if (enforcedDirections.size() > 0):
		enforcedDirections.clear()
	if (speedModifiers.size() > 0):
		for i in speedModifiers.size():
			finalSpeedModifier += speedModifiers[i].speedModifyValue
			if (speedModifiers[i].enforceDirection):
				enforcedDirections.push_back(speedModifiers[i].forwardDirection)
