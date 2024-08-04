class_name PlayerAim
extends Node2D

@export var offsetDegrees: float

func _physics_process(_delta):
	SetRotation()

func SetRotation():
	look_at(get_global_mouse_position())
	rotation_degrees += offsetDegrees
