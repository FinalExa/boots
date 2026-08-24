extends EnemyNode

@export var enemyDetection: EnemyDetection
@export var bossRobotMissileCheck: BossRobotMissileCheck
@export var enemyMovement: EnemyMovement

func Evaluate(_delta):
	if (enemyDetection.playerFound):
		enemyMovement.ResetMovementSpeed()
		enemyMovement.SetNewTarget(bossRobotMissileCheck.missilePoint)
		return NodeState.FAILURE
	return NodeState.SUCCESS
