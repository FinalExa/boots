class_name PlayerCharacter
extends CharacterBody2D

@export var playerMovements: PlayerMovements
var collisionResult: bool

func _physics_process(delta):
	collisionResult = move_and_slide()
