class_name EnemyHealth
extends Node

signal enemyDeath

@export var maxHealth: float
@export var enemyController: EnemyController
@export var enemyShielded: EnemyShielded
@export var bar: TextureProgressBar
var extraDamageEffects: Array[EffectOverTime]
var currentObjective: MapObjective
var currentHealth: float = 0

func _ready():
	HealthStartup()

func HealthStartup():
	HealthUpdate(maxHealth, self)

func HealthUpdate(valueChange: float, source: Node):
	if (valueChange <= 0 && enemyShielded.shieldedBy != null):
		valueChange = 0
		enemyShielded.RemoveShielded()
	ModifyHealth(valueChange)
	if (currentHealth <= 0):
		if (currentObjective != null):
			currentObjective.RequestEnemyData(enemyController)
		emit_signal("enemyDeath")
		enemyController.Death()
		return
	if (!(source is EffectOverTime)): LaunchExtraDamageEffects(valueChange)

func ModifyHealth(valueChange: float):
	currentHealth = clamp(currentHealth + valueChange, 0, maxHealth)
	bar.max_value = maxHealth * 100
	bar.value = currentHealth * 100

func RegisterExtraDamageEffect(effect: EffectOverTime):
	if (!extraDamageEffects.has(effect)):
		extraDamageEffects.push_back(effect)

func UnregisterExtraDamageEffect(effect: EffectOverTime):
	if (extraDamageEffects.has(effect)):
		extraDamageEffects.erase(effect)

func LaunchExtraDamageEffects(value: float):
	for i in extraDamageEffects.size():
		var returnedValue: float = extraDamageEffects[i].ConditionalEffect(value)
		if (returnedValue != 0): ModifyHealth(value)

func _on_enemy_damaged(damageReceived: float, source: Node):
	HealthUpdate(-damageReceived, source)
