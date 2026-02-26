extends TextureProgressBar

@export var playerMovements: PlayerMovements
@export var playerSpeedThresholds: PlayerSpeedThresholds
@export var barColors: Array[Color]
var savedSpeed: int
var savedAcceleration: int

func _ready():
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
