class_name EnemyShielding
extends Area2D

@export var controllerRef: EnemyController
@export var baseSprite: Sprite2D
@export var shieldingSprite: Sprite2D
@export var shieldCooldown: float
var shieldTimer: float
var possibleEnemies: Array[EnemyController]
var isShielding: EnemyShielded

func _ready():
	shieldTimer = shieldCooldown

func _process(delta):
	ShieldTimer(delta)

func ShieldTimer(delta):
	if (shieldTimer > 0):
		shieldTimer -= delta
	else:
		SelectAllyToShield()

func SelectAllyToShield():
	if (isShielding == null && possibleEnemies.size() > 0):
		var selectedEnemy: EnemyController
		for i in possibleEnemies.size():
			if (selectedEnemy == null && possibleEnemies[i].enemyShielded.shieldedBy == null):
				selectedEnemy = possibleEnemies[i]
				break
			if (possibleEnemies[i].enemyShielded.shieldedBy == null && controllerRef.global_position.distance_to(possibleEnemies[i].global_position) < controllerRef.global_position.distance_to(selectedEnemy.global_position)):
				selectedEnemy = possibleEnemies[i]
		if (selectedEnemy != null):
			isShielding = selectedEnemy.enemyShielded
			isShielding.SetShielded(self)
			baseSprite.hide()
			shieldingSprite.show()

func RemoveShield():
	baseSprite.show()
	shieldingSprite.hide()
	isShielding.shieldSprite.hide()
	isShielding.shieldedBy = null
	isShielding = null
	shieldTimer = shieldCooldown

func _on_body_entered(body):
	if (body is EnemyController && !possibleEnemies.has(body) && body != controllerRef):
		possibleEnemies.push_back(body)

func _on_body_exited(body):
	if (body is EnemyController && possibleEnemies.has(body)):
		possibleEnemies.erase(body)

func _on_enemy_health_enemy_death():
	if (isShielding != null):
		RemoveShield()
