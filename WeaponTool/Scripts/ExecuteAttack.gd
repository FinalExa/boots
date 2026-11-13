class_name ExecuteAttack
extends Node2D

@export var attackDuration: int
@export var attackCooldown: int
@export var attackPhasesLaunch: Array[int]
@export var attackHitboxes: Array[Node2D]
@export var attackSounds: Array[AudioStreamPlayer]
@export var attackMovements: Array[float]
@export var ignoreAttackMovement: bool
@export var characterRef: CharacterBody2D
var frameMaster: FrameMaster
var attackHitboxInstance: Node2D
var movementDirection: Vector2

var attackLaunched: bool
var cooldownActive: bool
var attackFrame: int
var currentPhase: int

func _ready():
	frameMaster = get_tree().root.get_child(0).frameMaster
	frameMaster.RegisterAttack(self)
	RemoveAttackHitboxes()
	currentPhase = 0
	ExtraReadyOperations()
	
func ExtraReadyOperations():
	pass

func Attacking():
	if (cooldownActive):
		CooldownExecute()
		return
	if (attackLaunched):
		AttackExecute()

func AttackExecute():
	LaunchNewPhase()
	if (attackFrame < attackDuration):
		AttackMovement(currentPhase - 1)
		attackFrame += 1
		return
	EndAttack()

func LaunchNewPhase():
	if (currentPhase < attackPhasesLaunch.size() && attackFrame >= attackPhasesLaunch[currentPhase]):
		ExecuteAttackPhase()

func CooldownExecute():
	if (attackFrame < attackCooldown):
		ActiveCooldownFeedback()
		attackFrame += 1
	else:
		EndCooldown()

func AddAttackHitbox(index):
	if (index < attackHitboxes.size()):
		if (attackSounds[index] != null && !attackSounds[index].playing): attackSounds[index].play()
		if (attackHitboxes[index] != null):
			if (attackHitboxes[index] is AttackHitbox):
				attackHitboxes[index].characterRef = characterRef
				attackHitboxes[index].Enable()
				return
			if (attackHitboxes[index] is ObjectSpawner):
				attackHitboxes[index].call_deferred("SpawnObject")
				return
			attackHitboxes[index].show()

func RemoveAttackHitbox(index):
	if (index < attackHitboxes.size() && attackHitboxes[index] != null):
		if (attackHitboxes[index] is AttackHitbox):
			attackHitboxes[index].AttackEnd()
			attackHitboxes[index].Disable()
			return
		attackHitboxes[index].hide()

func StartAttack():
	attackLaunched = true
	attackFrame = 0
	ExecuteAttackPhase()

func ExecuteAttackPhase():
	if (!ignoreAttackMovement): characterRef.velocity = Vector2.ZERO
	PrepareHitboxes()
	currentPhase += 1
	movementDirection = characterRef.GetRotator().GetCurrentLookDirection()

func PrepareHitboxes():
	if (currentPhase > 0):
		RemoveAttackHitbox(currentPhase - 1)
	AddAttackHitbox(currentPhase)

func EndAttack():
	if (currentPhase >= attackPhasesLaunch.size()):
		RemoveAttackHitbox(attackPhasesLaunch.size() - 1)
		characterRef.velocity = Vector2.ZERO
		currentPhase = 0
		attackLaunched = false
		if (attackCooldown == 0):
			FinalizeAttack()
		else:
			StartCooldown()

func ForceStartCooldown():
	attackLaunched = false
	RemoveAttackHitboxes()
	currentPhase = 0
	if (attackCooldown == 0):
		FinalizeAttack()
	else:
		StartCooldown()

func ForceEndCooldown():
	cooldownActive = false
	attackLaunched = false

func FinalizeAttack():
	attackLaunched = false

func StartCooldown():
	cooldownActive = true
	attackFrame = 0

func EndCooldown():
	cooldownActive = false
	EndCooldownFeedback()

func RemoveAttackHitboxes():
	for i in attackHitboxes.size():
		RemoveAttackHitbox(i)

func AttackMovement(index: int):
	if (!ignoreAttackMovement && attackMovements.size() > 0 && index < attackMovements.size() && attackMovements[index] != null):
		var velocityValue: Vector2 = attackMovements[index] * movementDirection
		characterRef.velocity = velocityValue

func ActiveCooldownFeedback():
	pass

func EndCooldownFeedback():
	pass
