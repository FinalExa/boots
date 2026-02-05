class_name PowerUpTrail
extends PowerUp

@export var trailSpawners: Array[ObjectSpawner]
@export var trailInterval: float
var trailTimer: float

func _process(delta):
	ExecuteTrail(delta)

func ExecuteTrail(delta):
	if (playerRef != null && playerRef.playerMovements.currentSpeed > playerRef.playerMovements.killSpeedValue):
		if (trailTimer > 0):
			trailTimer -= delta
			return
		trailTimer = trailInterval
		LaunchSpawners(trailSpawners)
