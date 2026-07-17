class_name PowerUpShoot
extends PowerUp

@export var shootObjectSpawners: Array[ObjectSpawner]

func EffectOnShotTarget(target: EnemyController, index: int):
	if (index > 0):
		ApplyPowerUpOnTarget(target, index)

func ApplyPowerUpOnTarget(target: EnemyController, index: int):
	var powerUp: PowerUpObjects = CreatePowerUpEffect(shootObjectSpawners[index-1])
	powerUp.ref = target
	call_deferred("RepositionPowerUp", powerUp, target)

func RepositionPowerUp(powerUp: PowerUpObjects, target: EnemyController):
	if (powerUp.get_parent() != target): powerUp.reparent(target)
	powerUp.position = Vector2.ZERO
