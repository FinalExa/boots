extends MapObjective

@export var enemies: Array[EnemyController]
var startingSize: int

func ReadyOperations():
	RegisterMapObjective()

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
			ObjectiveCompleted()
		else:
			playerRef.currentObjectiveUI.UpdateText(objectiveDescription, str(objectiveNotCompletedDescription, enemies.size(), "/", startingSize))
