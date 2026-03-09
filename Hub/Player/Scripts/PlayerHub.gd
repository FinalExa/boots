class_name PlayerHub
extends CharacterBody2D

@export var playerInputs: PlayerInputs

func _physics_process(_delta):
	move_and_slide()
