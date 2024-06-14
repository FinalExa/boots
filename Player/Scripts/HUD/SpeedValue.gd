extends Label

@export var playerMovements: PlayerMovements
@export var speedThresholds: PlayerSpeedThresholds
var savedSpeedValue: int

func _process(_delta):
	SetText()

func SetText():
	if (savedSpeedValue != playerMovements.currentSpeed):
		savedSpeedValue = int(playerMovements.currentSpeed)
		self.text = str("ACCELERATION: ", int(playerMovements.currentAcceleration), ", SPEED: ", savedSpeedValue, " ", speedThresholds.speedIndex)
