class_name PowerUpAura
extends PowerUp

@export var swapMode: bool
@export var spawners: Array[ObjectSpawner]
@export var delay: float
var currentTimer: float
var index: int
var oldIndex: int = 0
var currentPowerUp: PowerUpObjects

func _ready():
	currentTimer = delay

func _process(delta):
	AuraEffect(delta)

func AuraEffect(delta):
	index = powerUpManager.playerSpeedThresholds.speedIndex
	if (swapMode): SwapMode(index)
	else: SpawnMode(delta, index)

func SpawnMode(delta, index: int):
	if (currentTimer > 0):
		currentTimer -= delta
		return
	if (index != 0): CreatePowerUpEffect(spawners[index - 1])
	currentTimer += delay

func SwapMode(index: int):
	if (index != 0 && oldIndex != index):
		oldIndex = index
		if (currentPowerUp != null): currentPowerUp.DeleteSelf()
		currentPowerUp = CreatePowerUpEffect(spawners[index - 1])
