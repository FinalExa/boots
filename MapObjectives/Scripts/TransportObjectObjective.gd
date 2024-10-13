class_name TransportObjectObjective
extends MapObjective

@export var transportObjectSpawner: ObjectSpawner
@export var transportDestinations: Array[TransportDestination]
@export var multipleObjectSpawners: Array[MultipleObjectSpawner]
@export var spawnNewWaveCD: float
var transportObject: TransportObject
var completedDestinations: Array[TransportDestination]

var currentSpawnerIndex: int
var waveTimer: float

func ReadyOperations():
	GenerateTransportObject()
	RegisterDestinations()
	RegisterSpawners()
	currentSpawnerIndex = 0
	waveTimer = 0
	playerRef.currentObjectiveUI.UpdateText(objectiveDescription, str(objectiveNotCompletedDescription, completedDestinations.size(), "/", transportDestinations.size()))

func _process(delta):
	WaveCooldown(delta)

func RegisterDestinations():
	for i in transportDestinations.size():
		transportDestinations[i].mapObjective = self

func GenerateTransportObject():
	if (transportObjectSpawner != null && completedDestinations.size() < multipleObjectSpawners.size()):
		if (transportObject != null):
			transportObject.SelfDestruct()
		transportObject = transportObjectSpawner.SpawnObject()

func SetDestinationCompleted(destinationToComplete: TransportDestination):
	if (!completedDestinations.has(destinationToComplete)):
		completedDestinations.push_back(destinationToComplete)
		if (completedDestinations.size() == transportDestinations.size()):
			playerRef.currentObjectiveUI.UpdateText(objectiveDescription, objectiveCompletedDescription)
			ClearSpawners()
			ObjectiveCompleted()
			return
		playerRef.currentObjectiveUI.UpdateText(objectiveDescription, str(objectiveNotCompletedDescription, completedDestinations.size(), "/", transportDestinations.size()))

func RegisterSpawners():
	for i in multipleObjectSpawners.size():
		multipleObjectSpawners[i].mapObjective = self

func ClearSpawners():
	for i in multipleObjectSpawners.size():
		multipleObjectSpawners[i].ClearActiveObjects()

func WaveCooldown(delta):
	if (completedDestinations.size() < multipleObjectSpawners.size()):
		if (waveTimer > 0):
			waveTimer -= delta
			return
		SpawnWave()
	else:
		if (transportObject != null):
			transportObject.SelfDestruct()

func SpawnWave():
	if (currentSpawnerIndex >= multipleObjectSpawners.size()):
		currentSpawnerIndex = 0
	if (multipleObjectSpawners[currentSpawnerIndex].activeObjects.size() == 0): multipleObjectSpawners[currentSpawnerIndex].SpawnObjects()
	waveTimer = spawnNewWaveCD
	currentSpawnerIndex += 1
