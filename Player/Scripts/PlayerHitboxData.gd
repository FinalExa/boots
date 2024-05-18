class_name PlayerHitboxData
extends Area2D

@export var playerMovements: PlayerMovements
@export var damage: int
@export var repelDistance: float
@export var repelTime: float
var enemiesHit: Array[EnemyController]
var damageEnabled: bool

func _on_body_entered(body):
	if (body is EnemyController && !enemiesHit.has(body)):
		DealDamage(body)

func DealDamage(enemyController: EnemyController):
	if (damageEnabled):
		enemiesHit.push_back(enemyController)
		enemyController.ReceiveDamage(damage, repelDistance, playerMovements.currentDirection, repelTime)
		if (enemyController == null):
			enemiesHit.erase(enemyController)


func _on_body_exited(body):
	if (body is EnemyController && enemiesHit.has(body)):
		enemiesHit.erase(body)
