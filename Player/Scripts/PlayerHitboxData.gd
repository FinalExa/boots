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
@export var damage: float
@export var repelDistance: float
@export var repelTime: float
@export var lossOnImpact: float
@export var directSound: AudioStreamPlayer
@export var clashDamage: float
@export var clashRepelDistance: float
@export var clashRepelTime: float
@export var clashLossOnImpact: float
@export var clashSound: AudioStreamPlayer
@export var impactTypeIndicator: String
var damageEnabled: bool
var nodesInArea: Array[Node2D]
var areasInArea: Array[Area2D]

func _process(delta):
	DecideOutcome()

func DecideOutcome():
	if (damageEnabled):
		var alreadyHitEnemies: Array[Node2D]
		if (areasInArea.size() > 0):
			alreadyHitEnemies = CheckAreas(playerHitboxType, alreadyHitEnemies)
		if (nodesInArea.size() > 0):
			CheckCollisions(playerHitboxType, alreadyHitEnemies)
		alreadyHitEnemies.clear()

func CheckCollisions(type: PlayerHitboxType, hitEnemies: Array[Node2D]):
	if (nodesInArea.size() > 0):
		for i in nodesInArea.size():
			if (i >= nodesInArea.size()):
				break
			CollisionNodeCases(nodesInArea[i], type, hitEnemies)

func CollisionNodeCases(receivedNode: Node2D, type: PlayerHitboxType, hitEnemies: Array[Node2D]):
	if (receivedNode is EnemyController && !hitEnemies.has(receivedNode)):
		DetermineDamage(receivedNode)
		return
	if (receivedNode is Projectile):
		ProjectileCollision(receivedNode, type)

func DetermineDamage(enemyController: EnemyController):
	if (enemyController.enemyShielded.shieldedBy != null):
		Clash(enemyController)
		return
	Direct(enemyController)

func ProjectileCollision(projectile: Projectile, type: PlayerHitboxType):
	projectile.DeleteSelf()
	if (type != PlayerHitboxType.WEAK):
		CreateImpactTypeIndicator(false, self.global_position)
		if (type == PlayerHitboxType.NORMAL):
			playerMovements.UpdateCurrentSpeed(-lossOnImpact)
		return
	CreateImpactTypeIndicator(true, playerMovements.playerCharacter.global_position)
	playerMovements.UpdateCurrentSpeed(-clashLossOnImpact)

func CheckAreas(type: PlayerHitboxType, hitEnemies: Array[Node2D]):
	for i in areasInArea.size():
		if (i >= areasInArea.size()):
			break
		if (!hitEnemies.has(areasInArea[i].characterRef)):
			hitEnemies.push_back(areasInArea[i].characterRef)
			AssignAreaType(areasInArea[i].characterRef, type)
	return hitEnemies

func AssignAreaType(enemyController: EnemyController, type: PlayerHitboxType):
	if (type == PlayerHitboxType.STRONG):
		Direct(enemyController)
		return
	Clash(enemyController)

func Direct(enemyController: EnemyController):
	DealDamage(enemyController, damage, repelDistance, playerMovements.currentDirection, repelTime, lossOnImpact, false)

func Clash(enemyController: EnemyController):
	DealDamage(enemyController, clashDamage, clashRepelDistance, playerMovements.currentDirection, clashRepelTime, clashLossOnImpact, true)

func DealDamage(enemyController: EnemyController, damageDealt: float, repelDist: float, direction: Vector2, time: float, speedLoss: float, clash: bool):
	if (!enemyController.damageImmunity):
		enemyController.ReceiveDamage(damageDealt, repelDist, direction, time)
		if (clash):
			clashSound.play()
			emit_signal("hitClash")
		else:
			directSound.play()
			emit_signal("hitDirect")
		CreateImpactTypeIndicator(clash, self.global_position)
		playerMovements.UpdateCurrentSpeed(-speedLoss)


func CreateImpactTypeIndicator(clash: bool, currentPosition: Vector2):
	var obj_scene = load(impactTypeIndicator)
	var obj: ImpactTypeIndicator = obj_scene.instantiate()
	obj.Initialize(clash, currentPosition)
	get_tree().root.get_child(0).sceneSelector.currentScene.add_child(obj)

func TurnOffDamage():
	self.hide()
	damageEnabled = false

func TurnOnDamage():
	self.show()
	damageEnabled = true

func _on_body_entered(body):
	if ((body is EnemyController || body is Projectile) && !nodesInArea.has(body)):
		nodesInArea.push_back(body)

func _on_area_entered(area):
	if (area.is_in_group(clashGroupName) && area is AttackHitbox && !areasInArea.has(area)):
		if (CheckIfAreaHasCharacterRef(area)):
			areasInArea.push_back(area)

func _on_body_exited(body):
	if (nodesInArea.has(body)):
		nodesInArea.erase(body)

func _on_area_exited(area):
	if (areasInArea.has(area)):
		areasInArea.erase(area)

func CheckIfAreaHasCharacterRef(area):
	for i in areasInArea.size():
		if (areasInArea[i].characterRef == area.characterRef):
			return false
	return true
