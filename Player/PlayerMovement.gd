extends CharacterBody2D

@export var accelerationPerSecond = 20
@export var decelerationPerSecond = 10
@export var rotationSpeedPerSecond = 0.5
var currentSpeed
@export var maxSpeed = 2000
var currentDirection = Vector2(0,0)
var inputDirection
var xValue
var yValue

func _ready():
	currentSpeed = 0

func get_input():
	inputDirection = Input.get_vector("left", "right", "up", "down")
	
func set_current_speed(delta):
	if (inputDirection == Vector2.ZERO):
		currentSpeed-=decelerationPerSecond*delta
		if (currentSpeed == 0):
			currentDirection = Vector2.ZERO
	else:
		currentSpeed+=accelerationPerSecond*delta
		set_direction(delta)
	currentSpeed = clamp(currentSpeed, 0, maxSpeed)
	velocity = currentDirection * currentSpeed
	
func set_direction(delta):
	if (currentDirection == Vector2.ZERO):
		currentDirection=inputDirection
	else:
		calculate_rotation_direction()
		set_new_direction(delta)

func set_new_direction(delta):
	var minXValue
	var maxXValue
	if (xValue == -1):
		minXValue = inputDirection.x
		maxXValue = 1
	else:
		minXValue = -1
		maxXValue = inputDirection.x
	currentDirection.x = clamp(currentDirection.x+(xValue*rotationSpeedPerSecond*delta), minXValue, maxXValue)
	var minYValue
	var maxYValue
	if (yValue == -1):
		minYValue = inputDirection.y
		maxYValue = 1
	else:
		minYValue = -1
		maxYValue = inputDirection.y
	currentDirection.y = clamp(currentDirection.y+(yValue*rotationSpeedPerSecond*delta), minYValue, maxYValue)

func calculate_rotation_direction():
	if (currentDirection.x>inputDirection.x): xValue = -1
	else: xValue = 1
	if (currentDirection.y>inputDirection.y): yValue = -1
	else: yValue = 1

func _physics_process(delta):
	get_input()
	set_current_speed(delta)
	move_and_slide()
