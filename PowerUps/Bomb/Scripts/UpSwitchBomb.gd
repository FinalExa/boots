extends PowerUp

@export var spawner: ObjectSpawner

func ExecutePowerUpEffect():
	spawner.call_deferred("SpawnObject")
