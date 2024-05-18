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
		if (Input.is_action_just_pressed("Reload")):
			get_tree().reload_current_scene()
		if (Input.is_action_just_pressed("Close")):
			get_tree().quit()

func GetMovementInput():
	movementInput = Input.get_vector("left", "right", "up", "down")
