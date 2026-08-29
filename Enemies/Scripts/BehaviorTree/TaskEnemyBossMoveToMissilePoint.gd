extends EnemyNode

@export var enemyDetection: EnemyDetection
@export var bossRobotMissileCheck: BossRobotMissileCheck
@export var enemyMovement: EnemyMovement

func Evaluate(_delta):
	if (enemyDetection.playerFound && bossRobotMissileCheck.missilePoint != null && enemyController.global_position.distance_to(bossRobotMissileCheck.missilePoint.global_position) > bossRobotMissileCheck.pointDistance):
		enemyMovement.ResetMovementSpeed()
		enemyMovement.SetNewTarget(bossRobotMissileCheck.missilePoint)
		bossRobotMissileCheck.movingToMissilePoint = true
		return NodeState.FAILURE
	bossRobotMissileCheck.movingToMissilePoint = false
	return NodeState.FAILURE
