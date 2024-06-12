class_name PowerUpManager
extends Node2D

@export var playerMovements: PlayerMovements
@export var trailCooldown: float
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
		remove_child(powerUp)
		powerUp.queue_free()

func SwitchDown():
	downSwitchPowerUp.ExecutePowerUpEffect()

func SwitchUp():
	upSwitchPowerUp.ExecutePowerUpEffect()

func HitClash():
	contactPowerUp.SecondaryExecutePowerUpEffect()

func HitDirect():
	contactPowerUp.ExecutePowerUpEffect()

func ChargeWithSpeed():
	speedChargePowerUp.ExecutePowerUpEffectWithValue(playerMovements.currentSpeed)

func ExecuteTrail(delta):
	if (trailPowerUp != null && playerMovements.currentSpeed > playerMovements.killSpeedValue):
		if (trailTimer > 0):
			trailTimer -= delta
			return
		trailTimer = trailCooldown
		trailPowerUp.ExecutePowerUpEffect()
