class_name EnemyController
extends CharacterBody2D

@export var enemyMovement: EnemyMovement

func _physics_process(delta):
	move_and_slide()
