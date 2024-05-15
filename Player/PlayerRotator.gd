extends Node2D

@export var playerBody: CharacterBody2D
@export var playerMovements: PlayerMovements
@export var offsetDegrees: int

func _physics_process(_delta):
	SetRotation()

func SetRotation():
	if (playerMovements.currentDirection != Vector2.ZERO):
		look_at(playerBody.global_position + playerMovements.currentDirection)
		rotation_degrees += offsetDegrees
