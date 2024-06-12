class_name EnemyHealth
extends Node

signal enemyDeath

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
		emit_signal("enemyDeath")
		enemyController.enemyAttack.frameMaster.RemoveAttack(enemyController.enemyAttack)
		enemyController.queue_free()


func _on_enemy_damaged(damageReceived):
	HealthUpdate(-damageReceived)
