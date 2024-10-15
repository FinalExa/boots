class_name CaptureArea
extends Area2D

@export var maxCharge: float
@export var playerSpeedDivideValue: float
@export var chargeLabel: Label
var mapObjective: AreaCaptureObjective
var currentCharge: float
var playerRef: PlayerCharacter
var playerIn: bool
var completed: bool

func _ready():
	Initialize()

func Initialize():
	currentCharge = 0
	UpdateText()

func UpdateText():
	chargeLabel.text = str(snapped(currentCharge, 0.1), "/", maxCharge)

func _process(delta):
	IncreaseCharge(delta)

func IncreaseCharge(delta):
	if (!completed && playerIn):
		currentCharge = clamp(currentCharge + (delta * (playerRef.playerMovements.currentSpeed / playerSpeedDivideValue)), 0, maxCharge)
		UpdateText()
		if (currentCharge == maxCharge):
			completed = true
			mapObjective.CompleteCaptureArea(self)

func _on_body_entered(body):
	if (body is PlayerCharacter):
		playerRef = body
		playerIn = true

func _on_body_exited(body):
	if (body is PlayerCharacter):
		playerRef = null
		playerIn = false
