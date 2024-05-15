class_name PlayerInputs
extends Node

var inputDirection: Vector2

func _process(delta):
	GetInput()

func GetInput():
	inputDirection = Input.get_vector("left", "right", "up", "down")
