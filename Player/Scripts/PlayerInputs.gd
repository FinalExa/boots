class_name PlayerInputs
extends Node2D

var inputEnabled: bool
var movementInput: Vector2
var interactionInput: bool
var releaseSpeedCharge: bool
var ability1: bool
var ability2: bool
var aimInput: Vector2
var shootInput: bool
var sceneMaster: SceneMaster

func _ready():
	inputEnabled = true
	sceneMaster = get_tree().root.get_child(0)

func _process(_delta):
	GetInputs()

func GetInputs():
	if (inputEnabled):
		GetMovementInput()
		GetAimInput()
		GetShootInput()
		GetReleaseSpeedChargeInput()
		GetAbility1Input()
		GetAbility2Input()
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

func GetReleaseSpeedChargeInput():
	if (Input.is_action_just_pressed("ReleaseSpeedCharge")):
		releaseSpeedCharge = true
		return
	releaseSpeedCharge = false

func GetAbility1Input():
	if (Input.is_action_just_pressed("Ability1")):
		ability1 = true
		return
	ability1 = false

func GetAbility2Input():
	if (Input.is_action_just_pressed("Ability2")):
		ability2 = true
		return
	ability2 = false

func GetAimInput():
	aimInput = get_global_mouse_position()
	return

func GetShootInput():
	if (Input.is_action_just_pressed("Shoot")):
		shootInput = true
		return
	shootInput = false

func WinMap():
	if (Input.is_action_just_pressed("Win")):
		sceneMaster.sceneSelector.currentScene.SetObjectiveCompleted()
