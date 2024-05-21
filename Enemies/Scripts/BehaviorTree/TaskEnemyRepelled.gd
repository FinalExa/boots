extends EnemyNode

func Evaluate(_delta):
	if (enemyController.repelledActive):
		return NodeState.FAILURE
	return NodeState.SUCCESS
