class_name EffectOverTime
extends Node2D

@export var effectName: String
@export var frequencyType: Frequency
@export var stackable: bool
var ref: EnemyController
var damage: float
var initialized: bool
var duration: float
var timer: float
var intervalDuration: float
var intervalTimer: float
var source: PowerUp
var receivedSources: Array[PowerUp] 

enum Frequency
{
	CONSTANT,
	INTERVAL,
	END,
	CONDITIONAL
}

func _process(delta):
	EffectOverTimeTimer(delta)

func Initialize(enemy: EnemyController):
	ref = enemy
	timer = duration
	if (frequencyType == Frequency.INTERVAL):
		intervalTimer = intervalDuration
	initialized = true
	ReadyOperations()

func EffectOverTimeTimer(delta):
	if (initialized):
		if (ref != null):
			if (timer > 0):
				timer -= delta
				if (frequencyType == Frequency.INTERVAL):
					if (intervalTimer > 0):
						intervalTimer -= delta
						return
					intervalTimer += intervalDuration
					ExecuteEffect(delta)
					return
				if (frequencyType == Frequency.CONSTANT):
					ExecuteEffect(delta)
					return
			if (frequencyType == Frequency.END):
				ExecuteEffect(delta)
		ref.UnsetEffectOverTime(self)

func ReadyOperations():
	pass

func ExecuteEffect(_delta):
	pass

func ConditionalEffect(value):
	pass

func DeleteSelf():
	queue_free()

func Stack(effect: EffectOverTime):
	if (self.effectName == effect.effectName && self.source != effect.source && !receivedSources.has(effect.source)):
		self.damage += effect.damage
		self.timer += effect.duration
		receivedSources.push_back(effect.source)
