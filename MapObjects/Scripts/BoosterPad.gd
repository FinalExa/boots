class_name BoosterPad
extends SpeedModifier

@export var tolerance: float

func _process(_delta):
	IncreaseOrDecrease()

func IncreaseOrDecrease():
	if (playerMovements != null):
		var degrees: float = rad_to_deg(forwardDirection.angle_to(playerMovements.currentDirection))
		if (degrees >= 0 - tolerance && degrees <= 0 + tolerance):
			speedValue = speedModifyValue
		else:
			speedValue = -speedModifyValue
