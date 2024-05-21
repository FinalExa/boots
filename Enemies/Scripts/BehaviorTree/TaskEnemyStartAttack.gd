extends EnemyNode

@export var enemyMovement: EnemyMovement
@export var enemyAttack: ExecuteAttack

func Evaluate(_delta):
	if (enemyController.playerRef != null && !enemyAttack.attackLaunched && enemyController.global_position.distance_to(enemyController.playerRef.global_position) <= enemyController.attackDistance):
		enemyMovement.StopMovement()
		enemyAttack.StartAttack()
		return NodeState.FAILURE
	return NodeState.SUCCESS
