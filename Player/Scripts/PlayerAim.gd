class_name PlayerAim
extends Node2D

@export var playerInputs: PlayerInputs
@export var offsetDegrees: float

func _physics_process(_delta):
	SetRotation()

func SetRotation():
	look_at(playerInputs.aimInput)
	rotation_degrees += offsetDegrees
