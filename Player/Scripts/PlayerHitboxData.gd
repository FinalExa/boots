class_name PlayerHitboxData
extends Area2D

@export var playerMovements: PlayerMovements
@export var clashGroupName: String
@export var damage: int
@export var repelDistance: float
@export var repelTime: float
@export var lossOnImpact: float
@export var clashDamage: int
@export var clashRepelDistance: float
@export var clashRepelTime: float
@export var clashLossOnImpact: float
var enemiesHit: Array[EnemyController]
var damageEnabled: bool

func _on_body_entered(body):
	if (body is EnemyController):
		DealDamage(body, damage, repelDistance, playerMovements.currentDirection, repelTime, lossOnImpact, false)

func _on_area_entered(area):
	if (area.is_in_group(clashGroupName)):
		AssignAreaType(area)

func AssignAreaType(area):
	if (area is AttackHitbox):
		DealDamage(area.get_parent().characterRef, clashDamage, clashRepelDistance, playerMovements.currentDirection, clashRepelTime, clashLossOnImpact, true)

func DealDamage(enemyController: EnemyController, damageDealt: int, repelDist: float, direction: Vector2, time: float, speedLoss: float, clash: bool):
	if (damageEnabled && !enemyController.damageImmunity && !enemiesHit.has(enemyController)):
		enemiesHit.push_back(enemyController)
		enemyController.ReceiveDamage(damageDealt, repelDist, direction, time)
		if (enemyController == null):
			enemiesHit.erase(enemyController)
		if (clash):
			enemyController.enemyAttack.ForceStartCooldown()
		playerMovements.currentSpeed = clamp(playerMovements.currentSpeed - speedLoss, 0, playerMovements.maxSpeed)

func TurnOffDamage():
	damageEnabled = false
	enemiesHit.clear()

func _on_body_exited(body):
	if (body is EnemyController && enemiesHit.has(body)):
		enemiesHit.erase(body)

func _on_area_exited(area):
	if (area.is_in_group(clashGroupName)):
		if (area is AttackHitbox && enemiesHit.has(area.get_parent().characterRef)):
			enemiesHit.erase(area.get_parent().characterRef)
