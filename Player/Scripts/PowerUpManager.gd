class_name PowerUpManager
extends Node2D

@export var playerRef: PlayerCharacter
@export var playerMovements: PlayerMovements
@export var playerShooting: PlayerShooting
@export var playerSpeedThresholds: PlayerSpeedThresholds
@export var speedChargeBar: TextureProgressBar
@export var speedChargeLabel: Label
var contactPowerUp: PowerUpContact
var shootPowerUp: PowerUpShoot
var speedChargePowerUp: PowerUpSpeedCharge
var trailPowerUp: PowerUpTrail
var ability1PowerUp: PowerUp
var ability2PowerUp: PowerUp
var auraPowerUp: PowerUpAura
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
	if (powerUp is PowerUpAura):
		powerUp.Clear()
		ReplaceOldPowerUp(auraPowerUp)
		auraPowerUp = powerUp
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
	if (powerUp == auraPowerUp):
		auraPowerUp = null
		return
	if (powerUpPassives.has(powerUp)):
		powerUpPassives.erase(powerUp)
		return

func PlayerHasAnyBasePowerUpOfFaction(faction: PowerUp.PowerUpFaction):
	if (FactionCheck(contactPowerUp, faction) ||
	FactionCheck(shootPowerUp, faction) ||
	FactionCheck(trailPowerUp, faction) ||
	FactionCheck(speedChargePowerUp, faction) ||
	FactionCheck(ability1PowerUp, faction) ||
	FactionCheck(ability2PowerUp, faction) ||
	FactionCheck(auraPowerUp, faction)):
		return true
	return false

func FactionCheck(powerUp: PowerUp, factionToCheck: PowerUp.PowerUpFaction):
	if (powerUp != null && powerUp.powerUpFaction == factionToCheck):
		return true
	return false

func ReplaceOldPowerUp(powerUp: PowerUp):
	if (powerUp != null):
		powerUp.UnRegister()

func HitDirect(enemyController: EnemyController):
	if (contactPowerUp != null):
		contactPowerUp.HitDirect(enemyController, playerSpeedThresholds.speedIndex)

func HitClash(enemyController: EnemyController):
	if (contactPowerUp != null):
		contactPowerUp.HitClash(enemyController, playerSpeedThresholds.speedIndex)

func Ability1Used():
	if (ability1PowerUp != null):
		ability1PowerUp.ActivateAbilityPowerUp(playerSpeedThresholds.speedIndex)

func Ability2Used():
	if (ability2PowerUp != null):
		ability2PowerUp.ActivateAbilityPowerUp(playerSpeedThresholds.speedIndex)

func ShotTarget(enemyRef: EnemyController):
	if (enemyRef != null && shootPowerUp != null):
		shootPowerUp.EffectOnShotTarget(enemyRef, playerSpeedThresholds.speedIndex)
