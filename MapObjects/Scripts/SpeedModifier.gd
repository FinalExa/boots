class_name SpeedModifier
extends Area2D

@export var objectName: String
@export var speedModifyValue: float
@export var entranceValue: float
@export var enforceDirection: bool
@export var forward: Node2D

var playerMovements: PlayerMovements
var forwardDirection: Vector2
var speedValue: float

func _ready():
	if (forward != null):
		forwardDirection = self.global_position.direction_to(forward.global_position)
	else:
		forwardDirection = Vector2.ZERO
	speedValue = speedModifyValue

func BodyIn(body):
	if (body is PlayerCharacter):
		playerMovements = body.playerMovements.RegisterSpeedModifier(self)
		ApplyEntranceValue()

func BodyOut(body):
	if (body is PlayerCharacter && playerMovements != null):
		playerMovements = null
		body.playerMovements.UnregisterSpeedModifier(self)

func ApplyEntranceValue():
	var foundSameName: bool = false
	for i in playerMovements.speedModifiers.size():
		if (playerMovements.speedModifiers[i].objectName == objectName && playerMovements.speedModifiers[i] != self):
			foundSameName = true
			break
	if (!foundSameName):
		playerMovements.currentSpeed = clamp(playerMovements.currentSpeed + entranceValue, 0, playerMovements.maxSpeed)
