extends EnemyNode

func Evaluate(delta):
	if (enemyController.repelledActive):
		
		return NodeState.FAILURE
	return NodeState.SUCCESS
