extends CharacterBody2D

@export var accelerationPerSecond = 20
@export var decelerationPerSecond = 10
var currentSpeed
@export var maxSpeed = 2000
var inputDirection
var lastDirection

func _ready():
	currentSpeed = 0
	lastDirection = Vector2.ZERO

func get_input():
	inputDirection = Input.get_vector("left", "right", "up", "down")
	
func set_current_speed(delta):
	if (inputDirection == Vector2.ZERO):
		currentSpeed-=decelerationPerSecond*delta
	else:
		currentSpeed+=accelerationPerSecond*delta
		lastDirection = inputDirection
	currentSpeed = clamp(currentSpeed, 0, maxSpeed)
	velocity = lastDirection * currentSpeed

func _physics_process(delta):
	get_input()
	set_current_speed(delta)
	move_and_slide()
