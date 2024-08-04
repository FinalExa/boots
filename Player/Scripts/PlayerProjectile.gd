class_name PlayerProjectile
extends Projectile

func _on_projectile_area_body_entered(body):
	if (body is EnemyController):
		EnemyCollision(body)
		return

func _on_projectile_area_area_entered(area):
	if (area is AttackHitbox && area.characterRef is EnemyController):
		AttackHitboxCollision(area)
		return
	if (area is EnemySideShield && area.isActive):
		SideShieldCollision(area)

func EnemyCollision(enemyRef: EnemyController):
	enemyRef.ReceiveDamage(damage, 0, Vector2.ZERO, 0)
	call_deferred("DeleteSelf")

func AttackHitboxCollision(attackHitboxRef: AttackHitbox):
	attackHitboxRef.characterRef.ReceiveDamage(0, 0, Vector2.ZERO, 0)
	call_deferred("DeleteSelf")

func SideShieldCollision(sideShieldRef: EnemySideShield):
	sideShieldRef.TurnOff()
	call_deferred("DeleteSelf")
