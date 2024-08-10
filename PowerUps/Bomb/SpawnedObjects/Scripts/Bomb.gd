class_name Bomb
extends PowerUpObjects

@export var explosionCooldown: float
@export var explosionDuration: float
@export var explosionDamage: int
@export var explosionRepelDistance: float
@export var explosionRepelTime: float
@export var explosionCollider: Node2D
@export var bombSprite: Sprite2D
@export var explosionSprite: Sprite2D
@export var explodeWhenOneEnemyIsInRange: bool
@export var destroyOnEnd: Node2D
var baseDamage: float
var baseCooldown: float
var baseColliderSize: Vector2
var baseSpriteSize: Vector2
var currentDamage: float
var currentCooldown: float
var currentColliderSize: Vector2
var currentSpriteSize: Vector2
var timer: float
var enemiesInRange: Array[EnemyController]
var damagedEnemies: Array[EnemyController]
var isExploding: bool

func _ready():
	explosionSprite.hide()

func _process(delta):
	BombTimer(delta)

func SetBaseStats():
	baseDamage = explosionDamage
	currentDamage = baseDamage
	baseCooldown = explosionCooldown
	currentCooldown = baseCooldown
	baseColliderSize = explosionCollider.scale
	currentColliderSize = baseColliderSize
	baseSpriteSize = explosionSprite.scale
	currentSpriteSize = baseSpriteSize

func IncreaseStats(damage: float, size: float, time: float, specialObject: String):
	currentDamage += (baseDamage * (damage / 100))
	currentCooldown += (baseCooldown * (time / 100))
	currentColliderSize += (baseColliderSize * (size / 100))
	currentSpriteSize += (baseSpriteSize * (size / 100))
	SpawnSpecialObject(specialObject)
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
			enemiesInRange[i].ReceiveDamage(currentDamage, explosionRepelDistance, self.global_position.direction_to(enemiesInRange[i].global_position), explosionRepelTime)
			damagedEnemies.push_back(enemiesInRange[i])
	enemiesInRange.clear()

func DeleteSelf():
	if (destroyOnEnd == null):
		self.get_parent().remove_child(self)
		queue_free()
	else:
		destroyOnEnd.get_parent().remove_child(destroyOnEnd)
		destroyOnEnd.queue_free()

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
