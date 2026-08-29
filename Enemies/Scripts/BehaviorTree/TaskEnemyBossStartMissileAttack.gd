extends EnemyNode

@export var enemyMovement: EnemyMovement
@export var bossRobotMissileCheck: BossRobotMissileCheck
@export var enemyBossMissileAttack: ExecuteAttack
@export var enemySprite: AnimatedSprite2D
@export var enemyAttackAnimationName: String

func Evaluate(_delta):
	if (!bossRobotMissileCheck.movingToMissilePoint):
		enemyMovement.StopMovement()
		if (!enemyBossMissileAttack.attackLaunched && !enemyBossMissileAttack.cooldownActive):
			enemyController.enemyRotator.LookAtPlayer()
			enemyBossMissileAttack.StartAttack()
			bossRobotMissileCheck.StartMissileCooldown()
			if (enemySprite != null && enemyAttackAnimationName != ""):
				enemySprite.play(enemyAttackAnimationName)
		return NodeState.FAILURE
	if (!bossRobotMissileCheck.missileReady):
		if (enemyMovement.movementLocked):
			enemyMovement.UnlockMovement()
		if (enemyController.enemyRotator.rotationLocked):
			enemyController.enemyRotator.UnlockRotation()
	return NodeState.FAILURE
