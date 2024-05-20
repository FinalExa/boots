extends EnemyNode

@export var enemyMovement: EnemyMovement
@export var enemyAttack: ExecuteAttack

func Evaluate(delta):
	if (enemyController.playerRef != null && enemyController.global_position.distance_to(enemyController.playerRef.global_position) <= enemyController.attackDistance):
		enemyAttack.StartAttack()
		return NodeState.FAILURE
	return NodeState.SUCCESS
