extends EnemyNode

@export var bossRobotMissileCheck: BossRobotMissileCheck

func Evaluate(_delta):
	if (bossRobotMissileCheck.missileReady):
		return NodeState.FAILURE
	return NodeState.SUCCESS
