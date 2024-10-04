class_name DefeatWavesObjective
extends MapObjective

@export var multipleObjectSpawners: Array[MultipleObjectSpawner]
var currentWave: int
var startingSize: int

func ReadyOperations():
	Setup()

func Setup():
	currentWave = 0
	startingSize = multipleObjectSpawners.size()
	for i in multipleObjectSpawners.size():
		multipleObjectSpawners[i].mapObjective = self
	SpawnAndAdvanceWave()

func SpawnAndAdvanceWave():
	if (currentWave < multipleObjectSpawners.size()):
		playerRef.currentObjectiveUI.UpdateText(objectiveDescription, str(objectiveNotCompletedDescription, currentWave, "/", startingSize))
		multipleObjectSpawners[currentWave].SpawnObjects()
		currentWave += 1
	else:
		playerRef.currentObjectiveUI.UpdateText(objectiveDescription, objectiveCompletedDescription)
		ObjectiveCompleted()
