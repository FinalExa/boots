extends EnemyNode

@export var enemyMovement: EnemyMovement
@export var bossRobotMissileCheck: BossRobotMissileCheck
@export var enemyBossMissileAttack: ExecuteAttack
@export var enemySprite: AnimatedSprite2D
@export var enemyAttackAnimationName: String

func Evaluate(_delta):
	if (bossRobotMissileCheck.missilePoint != null && enemyController.global_position.distance_to(bossRobotMissileCheck.missilePoint.global_position) <= bossRobotMissileCheck.pointDistance):
		enemyMovement.StopMovement()
		if (!enemyBossMissileAttack.attackLaunched && !enemyBossMissileAttack.cooldownActive):
			enemyController.enemyRotator.LookAtPlayer()
			enemyBossMissileAttack.StartAttack()
			bossRobotMissileCheck.StartMissileCooldown()
			if (enemySprite != null && enemyAttackAnimationName != ""):
				enemySprite.play(enemyAttackAnimationName)
		return NodeState.FAILURE
	if (enemyMovement.movementLocked):
		enemyMovement.UnlockMovement()
	if (enemyController.enemyRotator.rotationLocked):
		enemyController.enemyRotator.UnlockRotation()
	return NodeState.SUCCESS
