class_name PlayerInputs
extends Node

var movementInput: Vector2
var inputEnabled: bool

func _ready():
	inputEnabled = true

func _process(_delta):
	GetInputs()

func GetInputs():
	if (inputEnabled):
		GetMovementInput()

func GetMovementInput():
	movementInput = Input.get_vector("left", "right", "up", "down")
