extends PowerUp

@export var damageChangePercentage: float
@export var sizeChangePercentage: float
@export var timeChangePercentage: float
@export var specialEffectAdd: String

func ActivateStatIncrease(requestingObject: PowerUpObjects):
	requestingObject.IncreaseStats(damageChangePercentage, sizeChangePercentage, timeChangePercentage, specialEffectAdd)
