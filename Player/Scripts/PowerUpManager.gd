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
var ability1PowerUp: PowerUp
var ability2PowerUp: PowerUp
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
	if (powerUp.powerUpType == PowerUp.PowerUpType.ABILITY1):
		ReplaceOldPowerUp(ability1PowerUp)
		ability1PowerUp = powerUp
	if (powerUp.powerUpType == PowerUp.PowerUpType.ABILITY2):
		ReplaceOldPowerUp(ability2PowerUp)
		ability2PowerUp = powerUp

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
	if (powerUp == ability1PowerUp):
		ability1PowerUp = null
		return
	if (powerUp == ability2PowerUp):
		ability2PowerUp = null
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
	if (playerRef.playerInputs.releaseSpeedCharge && speedChargePowerUp != null):
		speedChargePowerUp.SpeedChargeActivate()

func Ability1Used():
	if (ability1PowerUp != null):
		ability1PowerUp.ExecutePowerUpEffect()

func Ability2Used():
	if (ability2PowerUp != null):
		ability2PowerUp.ExecutePowerUpEffect()
