class_name PlayerProjectile
extends Projectile

var playerShooting: PlayerShooting

func CheckForBodies(body):
	if (body is EnemyController):
		EnemyCollision(body)
		return
	if (body is PlayerCharacter || body is PlayerProjectile):
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
	if (playerShooting != null): playerShooting.EnemyHit(enemyRef)
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
