class_name AreaCaptureObjective
extends MapObjective

@export var captureAreas: Array[CaptureArea]
@export var multipleObjectSpawners: Array[MultipleObjectSpawner]
@export var spawnNewWaveCD: float
var capturedAreas: Array[CaptureArea]
var currentSpawnerIndex: int
var waveTimer: float

func ReadyOperations():
	RegisterCaptureAreas()
	RegisterSpawners()
	currentSpawnerIndex = 0
	waveTimer = 0
	playerRef.currentObjectiveUI.UpdateText(objectiveDescription, str(objectiveNotCompletedDescription, capturedAreas.size(), "/", captureAreas.size()))

func _process(delta):
	WaveCooldown(delta)

func RegisterCaptureAreas():
	for i in captureAreas.size():
		captureAreas[i].mapObjective = self

func RegisterSpawners():
	for i in multipleObjectSpawners.size():
		multipleObjectSpawners[i].mapObjective = self

func CompleteCaptureArea(captureArea: CaptureArea):
	if (!capturedAreas.has(captureArea)):
		capturedAreas.push_back(captureArea)
		if (capturedAreas.size() == captureAreas.size()):
			playerRef.currentObjectiveUI.UpdateText(objectiveDescription, objectiveCompletedDescription)
			ClearSpawners()
			ObjectiveCompleted()
			return
		playerRef.currentObjectiveUI.UpdateText(objectiveDescription, str(objectiveNotCompletedDescription, capturedAreas.size(), "/", captureAreas.size()))

func ClearSpawners():
	for i in multipleObjectSpawners.size():
		multipleObjectSpawners[i].ClearActiveObjects()

func WaveCooldown(delta):
	if (capturedAreas.size() < captureAreas.size()):
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
