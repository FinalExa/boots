extends TextureProgressBar

@export var playerMovements: PlayerMovements
@export var playerSpeedThresholds: PlayerSpeedThresholds
@export var accelerationLabel: Label
@export var barColors: Array[Color]
var savedSpeed: int
var savedAcceleration: int

func _ready():
	accelerationLabel.text = str(0)
	max_value = playerMovements.maxSpeed
	tint_progress = barColors[0]

func _process(_delta):
	SetBar()

func SetBar():
	if (savedSpeed != playerMovements.currentSpeed):
		if (tint_progress != barColors[playerSpeedThresholds.speedIndex]):
			tint_progress = barColors[playerSpeedThresholds.speedIndex]
		savedSpeed = int(playerMovements.currentSpeed)
		value = savedSpeed
		var valueToShow: int
		if (!playerMovements.decelerating):
			valueToShow = int(playerMovements.currentAcceleration)
		else:
			valueToShow = int(playerMovements.effectiveDeceleration)
		accelerationLabel.text = str(valueToShow)
