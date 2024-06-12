class_name Bomb
extends CharacterBody2D

@export var explosionCooldown: float
@export var explosionDuration: float
@export var explosionDamage: int
@export var explosionRepelDistance: float
@export var explosionRepelTime: float
@export var bombSprite: Sprite2D
@export var explosionSprite: Sprite2D
var timer: float
var enemiesInRange: Array[EnemyController]
var damagedEnemies: Array[EnemyController]
var isExploding: bool

func _ready():
	explosionSprite.hide()
	timer = explosionCooldown

func _process(delta):
	BombTimer(delta)

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
		enemiesInRange[i].ReceiveDamage(explosionDamage, explosionRepelDistance, self.global_position.direction_to(enemiesInRange[i].global_position), explosionRepelTime)
		damagedEnemies.push_back(enemiesInRange[i])
	pass

func DeleteSelf():
	self.get_parent().remove_child(self)
	queue_free()

func _on_explosion_area_body_entered(body):
	if (body is EnemyController && !enemiesInRange.has(body) && !damagedEnemies.has(body)):
		enemiesInRange.push_back(body)

func _on_explosion_area_body_exited(body):
	if (body is EnemyController && enemiesInRange.has(body)):
		enemiesInRange.push_back(body)
