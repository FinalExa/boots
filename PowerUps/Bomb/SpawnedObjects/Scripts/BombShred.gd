class_name BombShred
extends EffectOverTime

func ConditionalEffect(value: float):
	if (value < 0):
		value = value * (damage/100)
		return value
	return 0
