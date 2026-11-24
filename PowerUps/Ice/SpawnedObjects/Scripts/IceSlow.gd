class_name IceSlow
extends EffectOverTime

var defaultMoveSpeed: float

func ExecuteEffect(delta):
	SetSlowOnEnemy(ref)

func OnEffectEnd():
	RemoveSlowOnEnemy(ref)

func SetSlowOnEnemy(enemy: EnemyController):
	defaultMoveSpeed = enemy.enemyMovement.defaultMovementSpeed
	enemy.enemyMovement.SetMovementSpeed(enemy.enemyMovement.defaultMovementSpeed / damage)
	enemy.enemyMovement.defaultMovementSpeed = defaultMoveSpeed / damage
	for i in enemy.allEnemyAttacks.size():
		enemy.allEnemyAttacks[i].SetSlow()

func RemoveSlowOnEnemy(enemy: EnemyController):
	enemy.enemyMovement.defaultMovementSpeed = defaultMoveSpeed
	enemy.enemyMovement.ResetMovementSpeed()
	for i in enemy.allEnemyAttacks.size():
		enemy.allEnemyAttacks[i].RemoveSlow()
