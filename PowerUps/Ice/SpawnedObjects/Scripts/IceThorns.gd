class_name IceThorns
extends EffectOverTime

@export var thornAmount: int
@export var spawnerRef: ObjectSpawner
@export var spawnRangeValue: float

func ReadyOperations():
	self.global_position = ref.global_position

func ExecuteEffect(_delta):
	for i in thornAmount:
		var thorn: IceThorn = spawnerRef.SpawnObject()
		thorn.global_position = self.global_position + Vector2(randf_range(-spawnRangeValue, spawnRangeValue), randf_range(-spawnRangeValue, spawnRangeValue))
		thorn.Initialize(damage, duration)
	ref.UnsetEffectOverTime(self)
