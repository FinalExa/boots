class_name PlayerHealth
extends Node

@export var healthLabel: Label
@export var maxHealth: float
@export var partialThreshold: float
@export var playerMovements: PlayerMovements
@export var invulnerabilityTime: float
var invulnerabilityTimer: float
var invulnerabilityActive: bool
var currentHealth: float

func _ready():
	UpdateHealthValue(maxHealth, 0)

func _process(delta):
	if (invulnerabilityActive):
		InvulnerabilityTimer(delta)

func UpdateHealthValue(valueToAdd: float, minValue: float):
	currentHealth = clamp(currentHealth + valueToAdd, minValue, maxHealth)
	UpdateLabel()
	if (currentHealth <= 0):
		get_tree().reload_current_scene()

func UpdateLabel():
	healthLabel.text = str("Integrity: ", currentHealth, "/", maxHealth)

func CheckForDamageType(fullDamage: float, partialDamage: float):
	if (playerMovements.currentSpeed > playerMovements.killSpeedValue && currentHealth > partialThreshold):
		UpdateHealthValue(-partialDamage, partialThreshold)
		StartInvulnerability()
		return
	UpdateHealthValue(-fullDamage, 0)
	StartInvulnerability()

func InvulnerabilityTimer(delta):
	if (invulnerabilityTimer > 0):
		invulnerabilityTimer -= delta
		return
	invulnerabilityActive = false

func StartInvulnerability():
	invulnerabilityTimer = invulnerabilityTime
	invulnerabilityActive = true
