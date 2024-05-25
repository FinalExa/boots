extends MapObjective

@export var enemies: Array[EnemyController]

func _ready():
	RegisterMapObjective()

func RegisterMapObjective():
	for i in enemies.size():
		enemies[i].enemyHealth.currentObjective = self

func RequestEnemyData(enemyController: EnemyController):
	RemoveEnemy(enemyController)

func RemoveEnemy(enemyToRemove: EnemyController):
	if (enemies.has(enemyToRemove)):
		enemies.erase(enemyToRemove)
		if (enemies.size() == 0):
			ObjectiveCompleted()
