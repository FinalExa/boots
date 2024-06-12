extends PowerUp

@export var spawner: ObjectSpawner

func ExecutePowerUpEffectWithValue(value):
	spawner.SpawnObject()
