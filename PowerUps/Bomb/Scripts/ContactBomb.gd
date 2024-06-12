extends PowerUp

@export var spawner: ObjectSpawner

func ExecutePowerUpEffect():
	spawner.SpawnObject()

func SecondaryExecutePowerUpEffect():
	spawner.SpawnObject()
