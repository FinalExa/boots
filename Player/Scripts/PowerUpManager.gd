class_name PowerUpManager
extends Node2D

@export var playerRef: PlayerCharacter
@export var playerMovements: PlayerMovements
@export var playerShooting: PlayerShooting
@export var speedChargeLabel: Label
var trailCooldown: float
var contactPowerUp: PowerUp
var shootPowerUp: PowerUp
var trailPowerUp: PowerUp
var speedChargePowerUp: PowerUp
var powerUpPassives: Array[PowerUp]
var lastDownIndex: int
var lastUpIndex: int
var trailTimer: float

func _ready():
	trailTimer = trailCooldown
	lastDownIndex = -1
	lastUpIndex = -1

func _process(delta):
	ExecuteTrail(delta)
	ReleaseSpeedCharge()
	ChargeWithSpeed()

func AssignPowerUp(powerUp: PowerUp):
	if (powerUp.powerUpType == PowerUp.PowerUpType.CONTACT):
		ReplaceOldPowerUp(contactPowerUp)
		contactPowerUp = powerUp
		return
	if (powerUp.powerUpType == PowerUp.PowerUpType.SHOOT):
		ReplaceOldPowerUp(shootPowerUp)
		shootPowerUp = powerUp
		playerShooting.SetCurrentShootingSettings(shootPowerUp.shootMaxProjectiles, shootPowerUp.shootProjectileRechargeTime, shootPowerUp.shootObjectPath, true)
		return
	if (powerUp.powerUpType == PowerUp.PowerUpType.TRAIL):
		ReplaceOldPowerUp(trailPowerUp)
		trailPowerUp = powerUp
		trailCooldown = trailPowerUp.trailInterval
		return
	if (powerUp.powerUpType == PowerUp.PowerUpType.SPEED_CHARGE):
		ReplaceOldPowerUp(speedChargePowerUp)
		speedChargePowerUp = powerUp
		speedChargePowerUp.speedChargeCurrentStacks = 0
		return
	if (powerUp.powerUpType == PowerUp.PowerUpType.PASSIVE):
		powerUpPassives.push_back(powerUp)
		return

func RemovePowerUp(powerUp: PowerUp):
	powerUp.powerUpManager = null
	playerRef.rewardSpawn.UnbanPowerUp(powerUp)
	powerUp.reparent(playerRef.rewardSpawn)
	if (powerUp == contactPowerUp):
		contactPowerUp = null
		return
	if (powerUp == shootPowerUp):
		shootPowerUp = null
		playerShooting.SetToBase()
		return
	if (powerUp == trailPowerUp):
		trailPowerUp = null
		return
	if (powerUp == speedChargePowerUp):
		speedChargePowerUp = null
		return
	if (powerUpPassives.has(powerUp)):
		powerUpPassives.erase(powerUp)
		return

func PlayerHasAnyBasePowerUpOfFaction(faction: PowerUp.PowerUpFaction):
	if (contactPowerUp != null && contactPowerUp.powerUpFaction == faction):
		return true
	if (shootPowerUp != null && shootPowerUp.powerUpFaction == faction):
		return true
	if (trailPowerUp != null && trailPowerUp.powerUpFaction == faction):
		return true
	if (speedChargePowerUp != null && speedChargePowerUp.powerUpFaction == faction):
		return true
	return false

func ReplaceOldPowerUp(powerUp: PowerUp):
	if (powerUp != null):
		powerUp.UnRegister()

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

func ReleaseSpeedCharge():
	if (speedChargePowerUp != null && playerRef.playerInputs.releaseSpeedCharge):
		speedChargePowerUp.SpeedChargeActivate()
