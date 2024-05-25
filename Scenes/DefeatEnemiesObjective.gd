extends MapObjective

@export var objectiveDescription: String
@export var objectiveCompletedDescription: String
@export var enemies: Array[EnemyController]
var startingSize: int

func ReadyOperations():
	RegisterMapObjective()

func RegisterMapObjective():
	for i in enemies.size():
		enemies[i].enemyHealth.currentObjective = self
	startingSize = enemies.size()
	playerRef.currentObjectiveUI.UpdateText(objectiveDescription, str("Enemies left: ", enemies.size(), "/", startingSize))

func RequestEnemyData(enemyController: EnemyController):
	RemoveEnemy(enemyController)

func RemoveEnemy(enemyToRemove: EnemyController):
	if (enemies.has(enemyToRemove)):
		enemies.erase(enemyToRemove)
		if (enemies.size() == 0):
			ObjectiveCompleted()
			playerRef.currentObjectiveUI.UpdateText(objectiveDescription, objectiveCompletedDescription)
		else:
			playerRef.currentObjectiveUI.UpdateText(objectiveDescription, str("Enemies left: ", enemies.size(), "/", startingSize))
