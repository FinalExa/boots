class_name PlayerAim
extends Node2D

@export var playerRef: PlayerCharacter
@export var playerInputs: PlayerInputs
@export var offsetDegrees: float
var lastInput: Vector2

func _physics_process(_delta):
	SetRotation()

func SetRotation():
	if (!playerInputs.controller):
		look_at(playerInputs.aimInput)
	else:
		if (playerInputs.aimInput != Vector2.ZERO):
			look_at(playerInputs.aimInput + playerRef.global_position)
			lastInput = playerInputs.aimInput
		else:
			look_at(lastInput + playerRef.global_position)
	rotation_degrees += offsetDegrees
