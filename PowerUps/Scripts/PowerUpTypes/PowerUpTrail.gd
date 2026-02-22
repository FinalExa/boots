class_name PowerUpTrail
extends PowerUp

@export var trailSpawners1: Array[ObjectSpawner]
@export var trailSpawners2: Array[ObjectSpawner]
@export var trailSpawners3: Array[ObjectSpawner]
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
		var index: int = powerUpManager.playerSpeedThresholds.speedIndex
		if (index == 1): LaunchSpawners(trailSpawners1)
		else:
			if (index == 2): LaunchSpawners(trailSpawners2)
			else:
				if (index == 3): LaunchSpawners(trailSpawners3)
