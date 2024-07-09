class_name PlayerInputs
extends Node

var movementInput: Vector2
var interactionInput: bool
var inputEnabled: bool
var sceneMaster: SceneMaster

func _ready():
	inputEnabled = true
	sceneMaster = get_tree().root.get_child(0)

func _process(_delta):
	GetInputs()

func GetInputs():
	if (inputEnabled):
		GetMovementInput()
		GetInteractionInput()
		if (Input.is_action_just_pressed("Reload")):
			get_tree().reload_current_scene()
		if (Input.is_action_just_pressed("Close")):
			get_tree().quit()

func GetMovementInput():
	movementInput = Input.get_vector("left", "right", "up", "down")

func GetInteractionInput():
	if (Input.is_action_just_pressed("Interact")):
		interactionInput = true
		return
	interactionInput = false

func WinMap():
	if (Input.is_action_just_pressed("Win")):
		sceneMaster.sceneSelector.currentScene.SetObjectiveCompleted()
