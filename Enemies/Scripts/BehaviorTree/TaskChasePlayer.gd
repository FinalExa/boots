extends EnemyNode

@export var enemyDetection: EnemyDetection
@export var enemyMovement: EnemyMovement

func Evaluate(_delta):
	if (enemyDetection.playerFound):
		enemyMovement.ResetMovementSpeed()
		enemyMovement.SetNewTarget(enemyDetection.playerRef)
		return NodeState.FAILURE
	return NodeState.SUCCESS
