class_name Ice
extends PowerUpObject

@export var iceDamage: float
@export var duration: float

var durationTimer: float
var enemiesInRange: Array[EnemyController]
var damagedEnemies: Array[EnemyController]
var currentDamage: float
var currentDuration: float
var currentEffectDamage: float
var currentEffectDuration: float

func _process(delta):
	DoDamageAndEffects()
	DurationTimer(delta)

func ReadyOperations():
	if (hasSpecialObject && specialObject != ""): SpawnSpecialObject(specialObject)

func DurationTimer(delta):
	if (durationTimer > 0):
		durationTimer -= delta
		return
	call_deferred("DeleteSelf")

func IncreaseStats(dataBlock: PowerUpPassiveDataBlock):
	currentDamage = (iceDamage * (dataBlock.damageBonus / 100))
	currentDuration = (duration * (dataBlock.timeBonus / 100))
	currentEffectDamage = (effectDamage * (dataBlock.damageBonus / 100))
	currentEffectDuration = (effectDuration * (dataBlock.timeBonus / 100))
	durationTimer = currentDuration

func DoDamageAndEffects():
	if (ref != null && ref is EnemyController && !damagedEnemies.has(ref)):
		if (currentDamage > 0):
			ref.ReceiveDamage(currentDamage, 0, Vector2.ZERO, 0, self)
		ref.SetEffectOverTime(SpawnEffectOverTime(currentEffectDamage, currentEffectDuration))
		damagedEnemies.push_back(ref)
	if (enemiesInRange.size() > 0):
		for i in enemiesInRange.size():
			if (!damagedEnemies.has(enemiesInRange[i])):
				if (currentDamage > 0):
					enemiesInRange[i].ReceiveDamage(currentDamage, 0, Vector2.ZERO, 0, self)
				enemiesInRange[i].SetEffectOverTime(SpawnEffectOverTime(currentEffectDamage, currentEffectDuration))
				damagedEnemies.push_back(enemiesInRange[i])

func ObjectInArea(body):
	if (body is EnemyController && !enemiesInRange.has(body)):
		enemiesInRange.push_back(body)

func ObjectOutOfArea(body):
	if (body is EnemyController && enemiesInRange.has(body)):
		enemiesInRange.erase(body)
