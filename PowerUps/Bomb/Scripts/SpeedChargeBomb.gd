extends PowerUp

@export var spawners: Array[ObjectSpawner]
@export var speedCapValue: float
var currentSpeedValue: float

func ExecutePowerUpEffectWithValue(value):
	currentSpeedValue += value * get_process_delta_time()
	powerUpManager.speedChargeLabel.text = str(int(currentSpeedValue), "/", speedCapValue)
	if (currentSpeedValue >= speedCapValue):
		currentSpeedValue -= speedCapValue
		for i in spawners.size():
			spawners[i].call_deferred("SpawnObject")
