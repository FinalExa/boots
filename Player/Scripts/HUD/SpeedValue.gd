extends Label

@export var playerMovements: PlayerMovements
@export var speedThresholds: PlayerSpeedThresholds

func _process(delta):
	SetText()

func SetText():
	var speedValue: int = playerMovements.currentSpeed
	self.text = str(speedValue, " ", speedThresholds.speedIndex)
