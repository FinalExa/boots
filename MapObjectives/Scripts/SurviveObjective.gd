class_name SurviveObjective
extends MapObjective

@export var surviveTime: float
@export var spawnNewWaveCD: float
@export var multipleObjectSpawners: Array[MultipleObjectSpawner]

var currentSpawnerIndex: int
var surviveTimer: float
var waveTimer: float

func ReadyOperations():
	RegisterSpawners()
	currentSpawnerIndex = 0
	surviveTimer = surviveTime
	waveTimer = 0

func RegisterSpawners():
	for i in multipleObjectSpawners.size():
		multipleObjectSpawners[i].mapObjective = self

func _process(delta):
	AdvanceCooldowns(delta)

func AdvanceCooldowns(delta):
	if (surviveTimer > 0):
		surviveTimer -= delta
		playerRef.currentObjectiveUI.UpdateText(objectiveDescription, str(objectiveNotCompletedDescription, snapped(surviveTimer, 0), "/", surviveTime))
		WaveCooldown(delta)
		return
	playerRef.currentObjectiveUI.UpdateText(objectiveDescription, objectiveCompletedDescription)
	ClearSpawners()
	ObjectiveCompleted()

func ClearSpawners():
	for i in multipleObjectSpawners.size():
		multipleObjectSpawners[i].ClearActiveObjects()

func WaveCooldown(delta):
	if (surviveTimer > 0):
		if (waveTimer > 0):
			waveTimer -= delta
			return
		SpawnWave()

func SpawnWave():
	if (currentSpawnerIndex >= multipleObjectSpawners.size()):
		currentSpawnerIndex = 0
	if (multipleObjectSpawners[currentSpawnerIndex].activeObjects.size() == 0): multipleObjectSpawners[currentSpawnerIndex].SpawnObjects()
	waveTimer = spawnNewWaveCD
	currentSpawnerIndex += 1
