extends EnemyNode

@export var enemyAttack: ExecuteAttack

func Evaluate(_delta):
	if (enemyAttack.attackLaunched || enemyAttack.cooldownActive):
		return NodeState.FAILURE
	return NodeState.SUCCESS
