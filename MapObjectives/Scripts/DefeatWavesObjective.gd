extends MapObjective

@export var multipleObjectSpawners: Array[MultipleObjectSpawner]
var currentWave: int
var startingSize: int

func ReadyOperations():
	Setup()

func Setup():
	currentWave = 0
	startingSize = 0
	for index in multipleObjectSpawners.size():
		startingSize += multipleObjectSpawners[index].ReturnCount()
		multipleObjectSpawners[index].mapObjective = self

