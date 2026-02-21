class_name PlayerProjectile
extends Projectile

func CheckForBodies(body):
	if (body is EnemyController):
		EnemyCollision(body)
		return
	call_deferred("DeleteSelf")

func CheckForAreas(area):
	if (area is AttackHitbox && area.characterRef is EnemyController):
		AttackHitboxCollision(area)
		return
	if (area is EnemySideShield):
		SideShieldCollision(area)
		return

func EnemyCollision(enemyRef: EnemyController):
	enemyRef.enemyHealth.HealthUpdate(-damage)
	call_deferred("DeleteSelf")

func AttackHitboxCollision(attackHitboxRef: AttackHitbox):
	if (!attackHitboxRef.characterRef.enemyAttack.attackLaunched):
		attackHitboxRef.characterRef.ForceStopAttack()
	else:
		EnemyCollision(attackHitboxRef.characterRef)
	call_deferred("DeleteSelf")

func SideShieldCollision(sideShieldRef: EnemySideShield):
	if (sideShieldRef.isActive):
		sideShieldRef.TurnOff()
		call_deferred("DeleteSelf")
