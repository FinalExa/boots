class_name EffectOverTime
extends Node2D

@export var frequencyType: Frequency
var ref: EnemyController
var initialized: bool
var duration: float
var timer: float
var intervalDuration: float
var intervalTimer: float

enum Frequency
{
	CONSTANT,
	INTERVAL,
	END
}

func _process(delta):
	EffectOverTimeTimer(delta)

func Initialize():
	timer = duration
	if (frequencyType == Frequency.INTERVAL):
		intervalTimer = intervalDuration
	initialized = true

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
		call_deferred("DeleteSelf")

func ExecuteEffect(_delta):
	pass

func DeleteSelf():
	queue_free()
