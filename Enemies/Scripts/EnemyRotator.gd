class_name EnemyRotator
extends Node2D

@export var enemyController: EnemyController
@export var enemyMovement: EnemyMovement
@export var rotationOffset: float

func _process(_delta):
	SetRotation()

func SetRotation():
	if (enemyMovement.dir != Vector2.ZERO):
		look_at(enemyController.global_position + enemyMovement.dir)
		rotation_degrees += rotationOffset

func GetCurrentLookDirection():
	return enemyMovement.dir
