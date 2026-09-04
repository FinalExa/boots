class_name BombDelayedExplosion
extends EffectOverTime

var damage: float

func ExecuteEffect(_delta):
	ref.enemyHealth.HealthUpdate(-damage)
