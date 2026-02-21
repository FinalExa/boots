class_name FireDoT
extends EffectOverTime

var damage: float 

func ExecuteEffect(delta):
	ref.enemyHealth.HealthUpdate(-damage * delta)
