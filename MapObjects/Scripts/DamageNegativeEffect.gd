extends PassiveNegativeEffect

@export var damageOverTime: float

func _process(delta):
	EffectAvailable(delta)

func ExecuteEffect(delta):
	playerRef.playerHealth.UpdateHealthValue(-damageOverTime * delta)
