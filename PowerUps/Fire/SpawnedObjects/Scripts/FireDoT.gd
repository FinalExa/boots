class_name FireDoT
extends EffectOverTime

func ExecuteEffect(delta):
	ref.enemyHealth.HealthUpdate(-damage * delta, self)
