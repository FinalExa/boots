class_name PlayerHub
extends CharacterBody2D

@export var hubData: HubData
@export var playerInputs: PlayerInputs
@export var abilitySelectScreen: AbilitySelectScreen

func _physics_process(_delta):
	move_and_slide()
