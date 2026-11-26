class_name Ice
extends PowerUpObject

@export var iceDamage: float
@export var iceDamageOverTime: float
@export var duration: float
@export var reEnterDamage: bool
@export var collisionShape: CollisionShape2D
@export var sprite: Sprite2D

var collisionShapeScale: Vector2
var spriteScale: Vector2

var durationTimer: float
var enemiesInRange: Array[EnemyController]
var damagedEnemies: Array[EnemyController]
var currentDamage: float
var currentDamageOverTime: float
var currentDuration: float
var currentEffectDamage: float
var currentEffectDuration: float

func _process(delta):
	DoDamageAndEffects()
	DamageOverTime(delta)
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
	currentDamageOverTime = (iceDamageOverTime * (dataBlock.damageBonus / 100))
	currentDuration = (duration * (dataBlock.timeBonus / 100))
	currentEffectDamage = (effectDamage * (dataBlock.damageBonus / 100))
	currentEffectDuration = (effectDuration * (dataBlock.timeBonus / 100))
	if (collisionShape != null):
		collisionShapeScale = (collisionShape.scale * (dataBlock.sizeBonus / 100))
		collisionShape.scale = collisionShapeScale
	if (sprite != null):
		spriteScale = (sprite.scale * (dataBlock.sizeBonus / 100))
		sprite.scale =  spriteScale
	durationTimer = currentDuration

func DoDamageAndEffects():
	if (ref != null && ref is EnemyController && !damagedEnemies.has(ref)):
		if (currentDamage > 0):
			ref.DealTrueDamage(currentDamage, 0, Vector2.ZERO, 0, self)
		ref.SetEffectOverTime(SpawnEffectOverTime(currentEffectDamage, currentEffectDuration))
		damagedEnemies.push_back(ref)
	if (enemiesInRange.size() > 0):
		for i in enemiesInRange.size():
			if (!damagedEnemies.has(enemiesInRange[i])):
				if (currentDamage > 0):
					enemiesInRange[i].DealTrueDamage(currentDamage, 0, Vector2.ZERO, 0, self)
				enemiesInRange[i].SetEffectOverTime(SpawnEffectOverTime(currentEffectDamage, currentEffectDuration))
				damagedEnemies.push_back(enemiesInRange[i])

func DamageOverTime(delta):
	if (iceDamageOverTime > 0):
		if (ref != null && ref is EnemyController):
			ref.DealTrueDamage(currentDamageOverTime * delta, 0, Vector2.ZERO, 0, self)
		if (enemiesInRange.size() > 0):
			for i in enemiesInRange.size():
				enemiesInRange[i].DealTrueDamage(currentDamageOverTime * delta, 0, Vector2.ZERO, 0, self)

func ObjectInArea(body):
	if (body is EnemyController && !enemiesInRange.has(body)):
		enemiesInRange.push_back(body)

func ObjectOutOfArea(body):
	if (body is EnemyController && enemiesInRange.has(body)):
		enemiesInRange.erase(body)
		if (reEnterDamage && damagedEnemies.has(body)):
			damagedEnemies.erase(body)
