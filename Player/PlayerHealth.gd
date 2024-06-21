class_name PlayerHealth
extends Node

@export var healthLabel: Label
@export var maxHealth: float
@export var partialThreshold: float
@export var playerMovements: PlayerMovements
var currentHealth: float

func _ready():
	UpdateHealthValue(maxHealth, 0)

func UpdateHealthValue(valueToAdd: float, minValue: float):
	currentHealth = clamp(currentHealth + valueToAdd, minValue, maxHealth)
	UpdateLabel()
	if (currentHealth <= 0):
		get_tree().reload_current_scene()

func UpdateLabel():
	healthLabel.text = str("Health: ", currentHealth, "/", maxHealth)

func CheckForDamageType(fullDamage: float, partialDamage: float):
	if (playerMovements.currentSpeed > playerMovements.killSpeedValue && currentHealth > partialThreshold):
		UpdateHealthValue(-partialDamage, partialThreshold)
		return
	UpdateHealthValue(-fullDamage, 0)
