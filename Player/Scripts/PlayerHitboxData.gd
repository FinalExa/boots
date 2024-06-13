class_name PlayerHitboxData
extends Area2D

signal hitClash
signal hitDirect

enum PlayerHitboxType
{
	WEAK,
	NORMAL,
	STRONG
}

@export var playerMovements: PlayerMovements
@export var playerHitboxType: PlayerHitboxType
@export var clashGroupName: String
@export var damage: int
@export var repelDistance: float
@export var repelTime: float
@export var lossOnImpact: float
@export var directSound: AudioStreamPlayer
@export var clashDamage: int
@export var clashRepelDistance: float
@export var clashRepelTime: float
@export var clashLossOnImpact: float
@export var clashSound: AudioStreamPlayer
@export var impactTypeIndicator: String
var enemiesHit: Array[EnemyController]
var damageEnabled: bool

func _on_body_entered(body):
	if (damageEnabled):
		CheckCollision(body, playerHitboxType)

func _on_area_entered(area):
	if (damageEnabled):
		CheckArea(area, playerHitboxType)

func CheckCollision(body, type: PlayerHitboxType):
	if (body is EnemyController):
		DetermineDamage(body, type)
		return
	if (body is Projectile):
		ProjectileCollision(body, type)

func CheckArea(area, type: PlayerHitboxType):
	if (area.is_in_group(clashGroupName)):
		if (area is AttackHitbox):
			AssignAreaType(area.characterRef, type)

func AssignAreaType(enemyController: EnemyController, type: PlayerHitboxType):
	if (type == PlayerHitboxType.STRONG):
		Direct(enemyController)
		return
	Clash(enemyController)

func DetermineDamage(enemyController: EnemyController, type: PlayerHitboxType):
	if (enemyController.enemyShielded.shieldedBy != null):
		Clash(enemyController)
		return
	Direct(enemyController)

func Direct(enemyController: EnemyController):
	DealDamage(enemyController, damage, repelDistance, playerMovements.currentDirection, repelTime, lossOnImpact, false)

func Clash(enemyController: EnemyController):
	DealDamage(enemyController, clashDamage, clashRepelDistance, playerMovements.currentDirection, clashRepelTime, clashLossOnImpact, true)

func DealDamage(enemyController: EnemyController, damageDealt: int, repelDist: float, direction: Vector2, time: float, speedLoss: float, clash: bool):
	if (!enemyController.damageImmunity && !enemiesHit.has(enemyController)):
		enemiesHit.push_back(enemyController)
		enemyController.ReceiveDamage(damageDealt, repelDist, direction, time)
		if (enemyController == null):
			enemiesHit.erase(enemyController)
		if (clash):
			clashSound.play()
			enemyController.enemyAttack.ForceStartCooldown()
			emit_signal("hitClash")
		else:
			directSound.play()
			emit_signal("hitDirect")
		CreateImpactTypeIndicator(clash, self.global_position)
		playerMovements.UpdateCurrentSpeed(-speedLoss)

func ProjectileCollision(projectile: Projectile, type: PlayerHitboxType):
	projectile.DeleteSelf()
	if (type != PlayerHitboxType.WEAK):
		CreateImpactTypeIndicator(false, self.global_position)
		if (type == PlayerHitboxType.NORMAL):
			playerMovements.UpdateCurrentSpeed(-lossOnImpact)
		return
	CreateImpactTypeIndicator(true, playerMovements.playerCharacter.global_position)
	playerMovements.UpdateCurrentSpeed(-clashLossOnImpact)

func CreateImpactTypeIndicator(clash: bool, currentPosition: Vector2):
	var obj_scene = load(impactTypeIndicator)
	var obj: ImpactTypeIndicator = obj_scene.instantiate()
	obj.Initialize(clash, currentPosition)
	get_tree().root.get_child(0).sceneSelector.currentScene.add_child(obj)

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
