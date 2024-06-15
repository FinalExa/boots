class_name PowerUpManager
extends Node2D

@export var playerMovements: PlayerMovements
@export var speedChargeLabel: Label
var trailCooldown: float
var contactPowerUp: PowerUp
var upSwitchPowerUp: PowerUp
var downSwitchPowerUp: PowerUp
var trailPowerUp: PowerUp
var speedChargePowerUp: PowerUp
var powerUpPassives: Array[PowerUp]
var trailTimer: float

func _ready():
	trailTimer = trailCooldown

func _process(delta):
	ExecuteTrail(delta)
	ChargeWithSpeed()

func AssignPowerUp(powerUp: PowerUp):
	if (powerUp.powerUpType == PowerUp.PowerUpType.CONTACT):
		ReplaceOldPowerUp(contactPowerUp)
		contactPowerUp = powerUp
		return
	if (powerUp.powerUpType == PowerUp.PowerUpType.UP_SWITCH):
		ReplaceOldPowerUp(upSwitchPowerUp)
		upSwitchPowerUp = powerUp
		return
	if (powerUp.powerUpType == PowerUp.PowerUpType.DOWN_SWITCH):
		ReplaceOldPowerUp(downSwitchPowerUp)
		downSwitchPowerUp = powerUp
		return
	if (powerUp.powerUpType == PowerUp.PowerUpType.TRAIL):
		ReplaceOldPowerUp(trailPowerUp)
		trailPowerUp = powerUp
		trailCooldown = trailPowerUp.trailInterval
		return
	if (powerUp.powerUpType == PowerUp.PowerUpType.SPEED_CHARGE):
		ReplaceOldPowerUp(speedChargePowerUp)
		speedChargePowerUp = powerUp
		return
	if (powerUp.powerUpType == PowerUp.PowerUpType.PASSIVE):
		powerUpPassives.push_back(powerUp)
		return

func ReplaceOldPowerUp(powerUp: PowerUp):
	if (powerUp != null):
		get_tree().root.get_child(0).sceneSelector.rewardSpawn.UnbanPowerUp(powerUp.scene_file_path)
		remove_child(powerUp)
		powerUp.queue_free()

func SwitchDown():
	if (downSwitchPowerUp != null):
		downSwitchPowerUp.ExecutePowerUpEffect()

func SwitchUp():
	if (upSwitchPowerUp != null):
		upSwitchPowerUp.ExecutePowerUpEffect()

func HitClash():
	if (contactPowerUp != null):
		contactPowerUp.SecondaryExecutePowerUpEffect()

func HitDirect():
	if (contactPowerUp != null):
		contactPowerUp.ExecutePowerUpEffect()

func ChargeWithSpeed():
	if (speedChargePowerUp != null):
		speedChargePowerUp.ExecutePowerUpEffectWithValue(playerMovements.currentSpeed)

func ExecuteTrail(delta):
	if (trailPowerUp != null && playerMovements.currentSpeed > playerMovements.killSpeedValue):
		if (trailTimer > 0):
			trailTimer -= delta
			return
		trailTimer = trailCooldown
		trailPowerUp.ExecutePowerUpEffect()
