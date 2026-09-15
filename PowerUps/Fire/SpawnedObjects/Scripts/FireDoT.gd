class_name FireDoT
extends EffectOverTime

var damage: float
var receivedSources: Array[PowerUp] 

func ExecuteEffect(delta):
	ref.enemyHealth.HealthUpdate(-damage * delta)

func Stack(effect: EffectOverTime):
	if (effect is FireDoT && self.source != effect.source && !receivedSources.has(effect.source)):
		self.damage += effect.damage
		self.timer += effect.duration
		receivedSources.push_back(effect.source)
