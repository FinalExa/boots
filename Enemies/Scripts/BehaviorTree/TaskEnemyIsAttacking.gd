extends EnemyNode

@export var enemyAttack: ExecuteAttack

func Evaluate(_delta):
	if (enemyAttack.attackLaunched):
		return NodeState.FAILURE
	if (enemyController.enemyMovement.movementLocked):
		enemyController.enemyMovement.UnlockMovement()
	return NodeState.SUCCESS
