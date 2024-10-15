class_name BountyObjective
extends MapObjective

@export var enemies: Array[EnemyController]
@export var multipleObjectSpawners: Array[MultipleObjectSpawner]
@export var spawnNewWaveCD: float

var currentSpawnerIndex: int
var waveTimer: float
var startingSize: int

func ReadyOperations():
	RegisterSpawners()
	RegisterMapObjective()

func _process(delta):
	WaveCooldown(delta)

func RegisterMapObjective():
	for i in enemies.size():
		enemies[i].enemyHealth.currentObjective = self
	startingSize = enemies.size()
	playerRef.currentObjectiveUI.UpdateText(objectiveDescription, str(objectiveNotCompletedDescription, enemies.size(), "/", startingSize))

func RequestEnemyData(enemyController: EnemyController):
	RemoveEnemy(enemyController)

func RemoveEnemy(enemyToRemove: EnemyController):
	if (enemies.has(enemyToRemove)):
		enemies.erase(enemyToRemove)
		if (enemies.size() == 0):
			playerRef.currentObjectiveUI.UpdateText(objectiveDescription, objectiveCompletedDescription)
			ClearSpawners()
			ObjectiveCompleted()
		else:
			playerRef.currentObjectiveUI.UpdateText(objectiveDescription, str(objectiveNotCompletedDescription, enemies.size(), "/", startingSize))

func RegisterSpawners():
	for i in multipleObjectSpawners.size():
		multipleObjectSpawners[i].mapObjective = self

func ClearSpawners():
	for i in multipleObjectSpawners.size():
		multipleObjectSpawners[i].ClearActiveObjects()

func WaveCooldown(delta):
	if (enemies.size() > 0):
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
