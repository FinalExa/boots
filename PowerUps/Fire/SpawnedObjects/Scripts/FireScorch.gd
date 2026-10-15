class_name FireScorch
extends EffectOverTime

@export var scorchCooldown: float
var scorchTimer: float = 0

func ExtraTimers(delta):
	if (scorchTimer > 0):
		scorchTimer -= delta
		return

func ConditionalEffect(value):
	if (scorchTimer <= 0 && value < 0):
		scorchTimer = scorchCooldown
		return damage
	return 0
