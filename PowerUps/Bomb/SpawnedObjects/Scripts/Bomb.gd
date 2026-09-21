class_name Bomb
extends PowerUpObject

@export var explosionCooldown: float
@export var explosionDuration: float
@export var explosionDamage: float
@export var explosionRepelDistance: float
@export var explosionRepelTime: float
@export var explosionCollider: Node2D
@export var bombSprite: Sprite2D
@export var explosionSprite: Sprite2D
@export var explodeWhenOneEnemyIsInRange: bool
@export var hasExplosionExtra: bool
@export var explosionExtraReference: String

var currentDamage: float
var currentCooldown: float
var currentColliderSize: Vector2
var currentSpriteSize: Vector2
var currentEffectDamage: float
var currentEffectDuration: float
var timer: float
var enemiesInRange: Array[EnemyController]
var damagedEnemies: Array[EnemyController]
var isExploding: bool

func _ready():
	explosionSprite.hide()
	self.global_rotation = 0

func _process(delta):
	BombTimer(delta)

func IncreaseStats(dataBlock: PowerUpPassiveDataBlock):
	currentDamage = (explosionDamage * (dataBlock.damageBonus / 100))
	currentCooldown = (explosionCooldown * (dataBlock.timeBonus / 100))
	currentColliderSize = (explosionCollider.scale * (dataBlock.sizeBonus / 100))
	currentSpriteSize = (bombSprite.scale * (dataBlock.sizeBonus / 100))
	if (hasEffect):
		currentEffectDamage = (effectDamage * (dataBlock.damageBonus / 100))
		currentEffectDuration = (effectDuration * (dataBlock.timeBonus / 100))
	SpawnSpecialObjects(dataBlock.specialObjects)
	pass

func Finalize():
	explosionCollider.scale = currentColliderSize
	explosionSprite.scale = currentSpriteSize
	timer = explosionCooldown

func BombTimer(delta):
	if (timer > 0):
		timer -= delta
		if (isExploding):
			DamageEnemies()
		return
	if (!isExploding):
		timer = explosionDuration
		bombSprite.hide()
		explosionSprite.show()
		isExploding = true
		return
	call_deferred("DeleteSelf")

func DamageEnemies():
	for i in enemiesInRange.size():
		if (enemiesInRange[i] != null):
			enemiesInRange[i].ReceiveDamage(currentDamage, explosionRepelDistance, self.global_position.direction_to(enemiesInRange[i].global_position), explosionRepelTime, self)
			CheckForEffects(enemiesInRange[i])
			CheckForAttach(enemiesInRange[i])
			damagedEnemies.push_back(enemiesInRange[i])
	enemiesInRange.clear()

func CheckForEffects(enemy: EnemyController):
	if (hasEffect && effect != ""):
		enemy.AddEffectOverTime(SpawnEffectOverTime(currentEffectDamage, currentEffectDuration))

func CheckForAttach(enemy: EnemyController):
	if (hasExplosionExtra):
		var extraBomb = SpawnExtra(explosionExtraReference)
		if (extraBomb is Bomb):
			for i in enemy.attachedObjects.get_child_count():
				if (enemy.attachedObjects.get_child(i) is Bomb):
					extraBomb.call_deferred("DeleteSelf")
					return
			enemy.add_child(extraBomb)
			extraBomb.global_position = enemy.global_position
			powerUpRef.InitializePowerUpObject(extraBomb)

func AutoTriggerExplosion():
	if (explodeWhenOneEnemyIsInRange && enemiesInRange.size() > 0):
		timer = 0

func _on_explosion_area_body_entered(body):
	if (body is EnemyController && !enemiesInRange.has(body) && !damagedEnemies.has(body)):
		enemiesInRange.push_back(body)
		AutoTriggerExplosion()

func _on_explosion_area_body_exited(body):
	if (body is EnemyController && enemiesInRange.has(body)):
		enemiesInRange.erase(body)

func AlternativeOutcome():
	timer = 0

func SpawnExtra(objToSpawn: String):
	var obj_scene = load(objToSpawn)
	var obj = obj_scene.instantiate()
	return obj
