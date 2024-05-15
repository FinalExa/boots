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

func set_current_speed(delta):
	if (playerInputs.inputDirection == Vector2.ZERO):
		currentSpeed-=decelerationPerSecond*delta
		if (currentSpeed == 0):
			currentDirection = Vector2.ZERO
	else:
		currentSpeed+=accelerationPerSecond*delta
		set_direction(delta)
	currentSpeed = clamp(currentSpeed, 0, maxSpeed)
	playerBody.velocity = currentDirection * currentSpeed
	
func set_direction(delta):
	if (currentDirection == Vector2.ZERO):
		currentDirection = playerInputs.inputDirection
	else:
		calculate_rotation_direction()
		set_new_direction(delta)

func set_new_direction(delta):
	var minXValue: float
	var maxXValue: float
	if (xValue == -1):
		minXValue = playerInputs.inputDirection.x
		maxXValue = 1
	else:
		minXValue = -1
		maxXValue = playerInputs.inputDirection.x
	currentDirection.x = clamp(currentDirection.x+(xValue*rotationSpeedPerSecond*delta), minXValue, maxXValue)
	var minYValue
	var maxYValue
	if (yValue == -1):
		minYValue = playerInputs.inputDirection.y
		maxYValue = 1
	else:
		minYValue = -1
		maxYValue = playerInputs.inputDirection.y
	currentDirection.y = clamp(currentDirection.y+(yValue*rotationSpeedPerSecond*delta), minYValue, maxYValue)

func calculate_rotation_direction():
	if (currentDirection.x > playerInputs.inputDirection.x): xValue = -1
	else: xValue = 1
	if (currentDirection.y > playerInputs.inputDirection.y): yValue = -1
	else: yValue = 1

func _physics_process(delta):
	set_current_speed(delta)
	playerBody.move_and_slide()
