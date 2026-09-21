class_name BombShred
extends EffectOverTime

func ReadyOperations():
	ref.enemyHealth.RegisterExtraDamageEffect(self)

func ConditionalEffect(value):
	if (value is float && value < 0):
		value = value * (damage/100)
		return value
	return 0
