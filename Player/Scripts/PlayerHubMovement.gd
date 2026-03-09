class_name PlayerHubMovement
extends Node

@export var playerHubRef: PlayerHub
@export var maxSpeed: float
@export var acceleration: float
var currentSpeed: float

func _ready():
	currentSpeed = 0

func _physics_process(delta):
	Movement(delta)

func Movement(delta):
	if (playerHubRef.playerInputs.movementInput != Vector2.ZERO):
		currentSpeed = clamp(currentSpeed + (acceleration * delta), 0, maxSpeed)
		playerHubRef.velocity = currentSpeed * playerHubRef.playerInputs.movementInput
		return
	playerHubRef.velocity = Vector2.ZERO
	currentSpeed = 0
