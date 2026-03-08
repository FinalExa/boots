class_name CaptureArea
extends Area2D

@export var maxCharge: float
@export var playerSpeedDivideValue: float
@export var chargeBar: TextureProgressBar
@export var transportDestination: TransportDestination
var currentCharge: float
var playerRef: PlayerCharacter
var playerIn: bool
var completed: bool
var areaActive: bool

func _ready():
	self.hide()

func Initialize():
	self.show()
	areaActive = true
	currentCharge = 0
	chargeBar.max_value = maxCharge * 10
	UpdateBar()

func UpdateBar():
	chargeBar.value = currentCharge * 10

func _process(delta):
	IncreaseCharge(delta)

func IncreaseCharge(delta):
	if (areaActive && !completed && playerIn):
		currentCharge = clamp(currentCharge + (delta * (playerRef.playerMovements.currentSpeed / playerSpeedDivideValue)), 0, maxCharge)
		UpdateBar()
		if (currentCharge == maxCharge):
			completed = true
			self.hide()
			transportDestination.SetCompleted()

func _on_body_entered(body):
	if (body is PlayerCharacter):
		playerRef = body
		playerIn = true

func _on_body_exited(body):
	if (body is PlayerCharacter):
		playerRef = null
		playerIn = false
