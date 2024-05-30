class_name EnemyRotator
extends Node2D

@export var enemyController: EnemyController
@export var enemyMovement: EnemyMovement
@export var rotationOffset: float
@export var pointer: Node2D
var rotationLocked: bool

func _physics_process(_delta):
	SetRotation()

func SetRotation():
	if (!rotationLocked && enemyMovement.dir != Vector2.ZERO):
		look_at(enemyController.global_position + enemyMovement.dir)
		rotation_degrees += rotationOffset

func LookAtPlayer():
	if (enemyController.playerRef != null):
		var direction = enemyController.global_position.direction_to(enemyController.playerRef.global_position)
		rotation = direction.angle()
		rotation_degrees += rotationOffset
		rotationLocked = true

func UnlockRotation():
	rotationLocked = false

func GetCurrentLookDirection():
	if (rotationLocked):
		return self.global_position.direction_to(pointer.global_position)
	return enemyMovement.dir
