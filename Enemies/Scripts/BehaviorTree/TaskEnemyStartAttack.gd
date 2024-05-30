extends EnemyNode

@export var enemyMovement: EnemyMovement
@export var enemyAttack: ExecuteAttack

func Evaluate(_delta):
	if (enemyController.playerRef != null && enemyController.global_position.distance_to(enemyController.playerRef.global_position) <= enemyController.attackDistance):
		enemyMovement.StopMovement()
		if (!enemyAttack.attackLaunched && !enemyAttack.cooldownActive):
			enemyController.enemyRotator.LookAtPlayer()
			enemyAttack.StartAttack()
		return NodeState.FAILURE
	if (enemyMovement.movementLocked):
		enemyMovement.UnlockMovement()
	if (enemyController.enemyRotator.rotationLocked):
		enemyController.enemyRotator.UnlockRotation()
	return NodeState.SUCCESS
