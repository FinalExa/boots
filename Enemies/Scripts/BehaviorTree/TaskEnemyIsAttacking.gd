extends EnemyNode

@export var enemyAttack: ExecuteAttack
@export var enemySprite: AnimatedSprite2D

func Evaluate(_delta):
	if (enemyAttack.attackLaunched || enemyAttack.cooldownActive):
		return NodeState.FAILURE
	if (enemySprite != null):
		enemySprite.play("default")
	return NodeState.SUCCESS
