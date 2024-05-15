extends Label

@export var playerMovements: PlayerMovements
@export var speedThresholds: PlayerSpeedThresholds
var savedSpeedValue: int

func _process(delta):
	SetText()

func SetText():
	if (savedSpeedValue != playerMovements.currentSpeed):
		savedSpeedValue = playerMovements.currentSpeed
		self.text = str(savedSpeedValue, " ", speedThresholds.speedIndex)
