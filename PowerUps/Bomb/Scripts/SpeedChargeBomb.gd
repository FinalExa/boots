extends PowerUp

@export var spawners: Array[ObjectSpawner]
@export var speedCapValue: float
var currentSpeedValue: float

func ExecutePowerUpEffectWithValue(value):
	currentSpeedValue += value
	if (currentSpeedValue >= speedCapValue):
		currentSpeedValue -= speedCapValue
		for i in spawners.size():
			spawners[i].SpawnObject()
