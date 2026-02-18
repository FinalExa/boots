extends TextureProgressBar

@export var playerMovements: PlayerMovements
@export var accelerationLabel: Label
var savedSpeedValue: int

func _ready():
	max_value = playerMovements.maxSpeed

func _process(_delta):
	SetText()

func SetText():
	if (savedSpeedValue != playerMovements.currentSpeed):
		savedSpeedValue = int(playerMovements.currentSpeed)
		accelerationLabel.text = str(int(playerMovements.currentAcceleration))
		value = savedSpeedValue
