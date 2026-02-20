class_name PowerUpManager
extends Node2D

@export var playerRef: PlayerCharacter
@export var playerMovements: PlayerMovements
@export var playerShooting: PlayerShooting
@export var speedChargeBar: TextureProgressBar
@export var speedChargeLabel: Label
var contactPowerUp: PowerUpContact
var shootPowerUp: PowerUpShoot
var speedChargePowerUp: PowerUpSpeedCharge
var trailPowerUp: PowerUpTrail
var ability1PowerUp: PowerUp
var ability2PowerUp: PowerUp
var powerUpPassives: Array[PowerUp]
var lastDownIndex: int
var lastUpIndex: int

func _ready():
	speedChargeBar.hide()
	lastDownIndex = -1
	lastUpIndex = -1

func AssignPowerUp(powerUp: PowerUp):
	if (powerUp is PowerUpContact):
		ReplaceOldPowerUp(contactPowerUp)
		contactPowerUp = powerUp
		return
	if (powerUp is PowerUpShoot):
		ReplaceOldPowerUp(shootPowerUp)
		shootPowerUp = powerUp
		playerShooting.SetCurrentShootingSettings(shootPowerUp.shootMaxProjectiles, shootPowerUp.shootProjectileRechargeTime, shootPowerUp.shootObjectPath, true)
		return
	if (powerUp is PowerUpSpeedCharge):
		ReplaceOldPowerUp(speedChargePowerUp)
		speedChargeBar.show()
		speedChargePowerUp = powerUp
		speedChargePowerUp.speedChargeCurrentValue = 0
		speedChargePowerUp.speedChargeCurrentStacks = 0
		speedChargeBar.max_value = speedChargePowerUp.speedChargeMaxValue * 100
		return
	if (powerUp is PowerUpTrail):
		ReplaceOldPowerUp(trailPowerUp)
		trailPowerUp = powerUp
		return
	if (powerUp is PowerUpAbility):
		if (!powerUp.secondAbilitySlot):
			ReplaceOldPowerUp(ability1PowerUp)
			ability1PowerUp = powerUp
			return
		ReplaceOldPowerUp(ability2PowerUp)
		ability2PowerUp = powerUp
	if (powerUp is PassivePowerUp):
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
	if (powerUp == speedChargePowerUp):
		speedChargePowerUp = null
		speedChargeBar.hide()
		return
	if (powerUp == trailPowerUp):
		trailPowerUp = null
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

func HitDirect(enemyController: EnemyController):
	if (contactPowerUp != null):
		contactPowerUp.HitDirect(enemyController)

func HitClash(enemyController: EnemyController):
	if (contactPowerUp != null):
		contactPowerUp.HitClash(enemyController)

func Ability1Used():
	if (ability1PowerUp != null):
		ability1PowerUp.LaunchSpawners(ability1PowerUp.abilitySpawners)

func Ability2Used():
	if (ability2PowerUp != null):
		ability2PowerUp.LaunchSpawners(ability2PowerUp.abilitySpawners)
