class_name Ice
extends PowerUpObject

@export var iceDamage: float

var enemiesInRange: Array[EnemyController]
var currentDamage: float
var currentEffectDamage: float
var currentEffectDuration: float

func _process(delta):
	DoDamage()
	ApplyEffect()
	if (hasSpecialObject && specialObject != ""): SpawnSpecialObject(specialObject)
	call_deferred("DeleteSelf")

func IncreaseStats(dataBlock: PowerUpPassiveDataBlock):
	currentDamage = (iceDamage * (dataBlock.damageBonus / 100))
	currentEffectDamage = (effectDamage * (dataBlock.damageBonus / 100))
	currentEffectDuration = (effectDuration * (dataBlock.timeBonus / 100))

func DoDamage():
	if (currentDamage > 0 && ref != null && ref is EnemyController):
		ref.ReceiveDamage(currentDamage, 0, Vector2.ZERO, 0, self)

func ApplyEffect():
	if (hasEffect):
		if (ref != null && ref is EnemyController):
			ref.SetEffectOverTime(SpawnEffectOverTime(currentEffectDamage, currentEffectDuration))
		if (enemiesInRange.size() > 0):
			for i in enemiesInRange.size():
				enemiesInRange[i].SetEffectOverTime(SpawnEffectOverTime(currentEffectDamage, currentEffectDuration))
