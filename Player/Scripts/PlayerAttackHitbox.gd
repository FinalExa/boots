class_name PlayerAttackHitbox
extends AttackHitbox

@export var damage: float
@export var repels: bool
@export var repelDistance: float
@export var repelTime: float

func _on_body_entered(body):
	if (body is EnemyController && !hitTargets.has(body)):
		AttackEnemy(body)

func AttackEnemy(enemyController: EnemyController):
	hitTargets.push_back(enemyController)
	if (!repels):
		enemyController.ReceiveDamage(damage, 0, Vector2.ZERO, 0)
	else:
		enemyController.ReceiveDamage(damage, repelDistance, characterRef.global_position.direction_to(enemyController.global_position), repelTime)
