class_name PlayerCharacter
extends CharacterBody2D

@export var playerMovements: PlayerMovements
@export var currentObjectiveUI: CurrentObjectiveUI
@export var playerSpeedThresholds: PlayerSpeedThresholds
@export var playerInputs: PlayerInputs
@export var powerUpUI: PowerUpUI
@export var powerUpManager: PowerUpManager
@export var playerHealth: PlayerHealth
var collisionResult: bool

func _physics_process(_delta):
	collisionResult = move_and_slide()
