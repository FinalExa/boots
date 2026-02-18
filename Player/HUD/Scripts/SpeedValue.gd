extends TextureProgressBar

@export var playerMovements: PlayerMovements
@export var accelerationLabel: Label
var savedSpeed: int
var savedAcceleration: int

func _ready():
	accelerationLabel.text = str(0)
	max_value = playerMovements.maxSpeed

func _process(_delta):
	SetText()

func SetText():
	if (savedSpeed != playerMovements.currentSpeed):
		savedSpeed = int(playerMovements.currentSpeed)
		value = savedSpeed
		if (savedSpeed != 0):
			var valueToShow: int
			if (!playerMovements.decelerating):
				valueToShow = int(playerMovements.currentAcceleration)
			else:
				valueToShow = int(playerMovements.effectiveDeceleration)
			accelerationLabel.text = str(valueToShow)
		else:
			accelerationLabel.text = str(0)
