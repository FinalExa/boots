class_name PowerUpSpeedCharge
extends PowerUp

@export var speedChargeMaxValue: float
@export var speedChargeMaxStacks: int
@export var speedChargeSpawners1: Array[ObjectSpawner]
@export var speedChargeSpawners2: Array[ObjectSpawner]
@export var speedChargeSpawners3: Array[ObjectSpawner]
var speedChargeCurrentValue: float
var speedChargeCurrentStacks: int

func _process(_delta):
	ReleaseSpeedCharge()
	ChargeWithSpeed()

func ChargeWithSpeed():
	if (playerRef != null):
		SpeedCharge(playerRef.playerMovements.currentSpeed)

func ReleaseSpeedCharge():
	if (playerRef != null && playerRef.playerInputs.releaseSpeedCharge && powerUpManager.playerSpeedThresholds.speedIndex > 0):
		SpeedChargeActivate(powerUpManager.playerSpeedThresholds.speedIndex)

func SpeedCharge(value):
	if (speedChargeCurrentStacks < speedChargeMaxStacks):
		speedChargeCurrentValue = clamp(speedChargeCurrentValue + value * get_process_delta_time(), 0, speedChargeMaxValue)
		if (speedChargeCurrentValue >= speedChargeMaxValue):
			speedChargeCurrentStacks += 1
			speedChargeCurrentValue -= speedChargeMaxValue
		powerUpManager.speedChargeBar.value = speedChargeCurrentValue * 100
		powerUpManager.speedChargeLabel.text = str(speedChargeCurrentStacks, "/", speedChargeMaxStacks)
		return
	if (powerUpManager.speedChargeBar.value != 0):
		powerUpManager.speedChargeBar.value = 0

func SpeedChargeActivate(index: int):
	if (speedChargeCurrentStacks > 0):
		if (index == 1): LaunchSpawners(speedChargeSpawners1)
		else:
			if (index == 2): LaunchSpawners(speedChargeSpawners2)
			else:
				if (index == 3): LaunchSpawners(speedChargeSpawners3)
		speedChargeCurrentStacks -= 1
