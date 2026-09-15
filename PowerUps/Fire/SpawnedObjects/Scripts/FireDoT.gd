class_name FireDoT
extends EffectOverTime

var damage: float 

func ExecuteEffect(delta):
	ref.enemyHealth.HealthUpdate(-damage * delta)

func Stack(effect: EffectOverTime):
	if (effect is FireDoT && self.source != effect.source):
		self.damage += effect.damage
		self.timer += effect.duration
