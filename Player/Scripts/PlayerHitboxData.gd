class_name PlayerHitboxData
extends Area2D

@export var playerMovements: PlayerMovements
@export var damage: int
@export var repelDistance: float
@export var repelTime: float
@export var lossOnImpact: float
var enemiesHit: Array[EnemyController]
var damageEnabled: bool

func _on_body_entered(body):
	if (body is EnemyController && !enemiesHit.has(body)):
		DealDamage(body)

func DealDamage(enemyController: EnemyController):
	if (damageEnabled && !enemyController.damageImmunity):
		enemiesHit.push_back(enemyController)
		enemyController.ReceiveDamage(damage, repelDistance, playerMovements.currentDirection, repelTime)
		if (enemyController == null):
			enemiesHit.erase(enemyController)
		playerMovements.currentSpeed = clamp(playerMovements.currentSpeed - lossOnImpact, 0, playerMovements.maxSpeed)

func TurnOffDamage():
	damageEnabled = false
	enemiesHit.clear()

func _on_body_exited(body):
	if (body is EnemyController && enemiesHit.has(body)):
		enemiesHit.erase(body)
