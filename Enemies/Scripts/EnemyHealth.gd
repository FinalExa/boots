class_name EnemyHealth
extends Node

signal enemyDeath

@export var maxHealth: float
@export var enemyController: EnemyController
@export var enemyShielded: EnemyShielded
@export var bar: TextureProgressBar
var currentObjective: MapObjective
var currentHealth: float = 0

func _ready():
	HealthStartup()

func HealthStartup():
	HealthUpdate(maxHealth)

func HealthUpdate(valueChange: float):
	if (valueChange <= 0 && enemyShielded.shieldedBy != null):
		valueChange = 0
		enemyShielded.RemoveShielded()
	currentHealth = clamp(currentHealth + valueChange, 0, maxHealth)
	bar.max_value = maxHealth * 100
	bar.value = currentHealth * 100
	if (currentHealth <= 0):
		if (currentObjective != null):
			currentObjective.RequestEnemyData(enemyController)
		emit_signal("enemyDeath")
		enemyController.UnsetDOT()
		enemyController.enemyAttack.frameMaster.RemoveAttack(enemyController.enemyAttack)
		enemyController.queue_free()


func _on_enemy_damaged(damageReceived):
	HealthUpdate(-damageReceived)
