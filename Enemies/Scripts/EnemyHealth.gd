class_name EnemyHealth
extends Node

@export var maxHealth: int
@export var enemyController: EnemyController
@export var label: Label
var currentObjective: MapObjective
var currentHealth: int = 0

func _ready():
	HealthStartup()

func HealthStartup():
	HealthUpdate(maxHealth)

func HealthUpdate(valueChange: int):
	currentHealth = clamp(currentHealth + valueChange, 0, maxHealth)
	label.text = str(currentHealth, "/", maxHealth)
	if (currentHealth <= 0):
		if (currentObjective != null):
			currentObjective.RequestEnemyData(enemyController)
		enemyController.get_parent().remove_child(enemyController)


func _on_enemy_damaged(damageReceived):
	HealthUpdate(-damageReceived)
