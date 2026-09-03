class_name PowerUpAura
extends PowerUp

@export var swapMode: bool
@export var spawners: Array[ObjectSpawner]
@export var delay: float
var currentTimer: float
var index: int
var oldIndex: int = 0
var currentPowerUp: PowerUpObjects

func ReadyOperations():
	currentTimer = delay

func _process(delta):
	if (powerUpManager != null):
		AuraEffect(delta)

func AuraEffect(delta):
	index = powerUpManager.playerSpeedThresholds.speedIndex
	if (swapMode):
		SwapMode()
		if (currentPowerUp != null): currentPowerUp.rotation_degrees = 0
	else: SpawnMode(delta)

func SpawnMode(delta):
	if (index != 0):
		if (currentTimer > 0):
			currentTimer -= delta
			return
		CreateAndAssignPowerup()
		currentTimer += delay

func SwapMode():
	if (index != 0 && oldIndex != index):
		oldIndex = index
		if (currentPowerUp != null):
			currentPowerUp.DeleteSelf()
			currentPowerUp = null
		currentPowerUp = CreateAndAssignPowerup()
	if (index == 0 && currentPowerUp != null):
		oldIndex = 0
		currentPowerUp.DeleteSelf()
		currentPowerUp = null

func Clear():
	if (swapMode && currentPowerUp != null):
		currentPowerUp.DeleteSelf()
		currentPowerUp = null

func CreateAndAssignPowerup():
	var powerUp: PowerUpObjects = CreatePowerUpEffect(spawners[index-1])
	call_deferred("ReparentAssignedPowerUp", powerUp)
	return powerUp

func ReparentAssignedPowerUp(powerUp: PowerUpObjects):
	if (powerUp.get_parent() != self || powerUp.get_parent() == null):
		if (powerUp.get_parent() != null): powerUp.reparent(self)
		else: add_child(powerUp)
	powerUp.position = Vector2.ZERO
