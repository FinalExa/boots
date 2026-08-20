class_name PlayerHeart
extends TextureProgressBar

@export var mult: float
@export var valueChangeSpeedPerSecond: float
var targetValue: float
var positive: bool
var valueChangeActive: bool

func Startup(max: float, min: float):
	max_value = max * mult
	min_value = min * mult
	SetFull()

func _process(delta):
	UpdateValueLive(delta)

func SetFull():
	value = max_value

func SetEmpty():
	UpdateHealth(min_value)

func UpdateHealth(newValue: float):
	targetValue = newValue * mult
	if (targetValue != value):
		valueChangeActive = true
		if (targetValue > value): positive = true
		else: positive = false
	else:
		valueChangeActive = false

func UpdateValueLive(delta):
	if (valueChangeActive):
		if (value != targetValue):
			if (positive):
				value = clamp(value + delta * mult * valueChangeSpeedPerSecond, 0, targetValue)
			else:
				value = clamp (value - delta * mult * valueChangeSpeedPerSecond, targetValue, max_value)
		return
		valueChangeActive = false
