class_name PowerUpSpeedCharge
extends PowerUp

@export var speedChargeMaxValue: float
@export var speedChargeMaxStacks: int
@export var speedChargeSpawners: Array[ObjectSpawner]
var speedChargeCurrentValue: float
var speedChargeCurrentStacks: int

func _process(_delta):
	ReleaseSpeedCharge()
	ChargeWithSpeed()

func ChargeWithSpeed():
	if (playerRef != null):
		SpeedCharge(playerRef.playerMovements.currentSpeed)

func ReleaseSpeedCharge():
	if (playerRef != null && playerRef.playerInputs.releaseSpeedCharge):
		SpeedChargeActivate()

func SpeedCharge(value):
	if (speedChargeCurrentStacks < speedChargeMaxStacks):
		speedChargeCurrentValue = clamp(speedChargeCurrentValue + value * get_process_delta_time(), 0, speedChargeMaxValue)
		if (speedChargeCurrentValue >= speedChargeMaxValue):
			speedChargeCurrentStacks += 1
			speedChargeCurrentValue -= speedChargeMaxValue
		powerUpManager.speedChargeLabel.text = str(int(speedChargeCurrentValue), "/", speedChargeMaxValue, " Stacks: ", speedChargeCurrentStacks, "/", speedChargeMaxStacks)

func SpeedChargeActivate():
	if (speedChargeCurrentStacks > 0):
		LaunchSpawners(speedChargeSpawners)
		speedChargeCurrentStacks -= 1
