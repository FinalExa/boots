class_name PowerUpManager
extends Node2D

@export var playerMovements: PlayerMovements
@export var speedChargeLabel: Label
@export var upSwitchAbuseTime: float
@export var downSwitchAbuseTime: float
var trailCooldown: float
var upSwitchAbuseTimer: float
var downSwitchAbuseTimer: float
var contactPowerUp: PowerUp
var upSwitchPowerUp: PowerUp
var downSwitchPowerUp: PowerUp
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
	UpSwitchAbuseTimer(delta)
	DownSwitchAbuseTimer(delta)
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

func SwitchDown(receivedIndex: int):
	if (downSwitchPowerUp != null):
		if (receivedIndex != lastDownIndex || (receivedIndex == lastDownIndex && downSwitchAbuseTimer <= 0)):
			downSwitchPowerUp.ExecutePowerUpEffect()
			downSwitchAbuseTimer = downSwitchAbuseTime
		lastDownIndex = receivedIndex

func SwitchUp(receivedIndex: int):
	if (upSwitchPowerUp != null):
		if (receivedIndex != lastUpIndex || (receivedIndex == lastUpIndex && upSwitchAbuseTimer <= 0)):
			upSwitchPowerUp.ExecutePowerUpEffect()
			upSwitchAbuseTimer = upSwitchAbuseTime
		lastUpIndex = receivedIndex

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

func UpSwitchAbuseTimer(delta):
	if (upSwitchAbuseTimer > 0):
		upSwitchAbuseTimer -= delta

func DownSwitchAbuseTimer(delta):
	if (downSwitchAbuseTimer > 0):
		downSwitchAbuseTimer -= delta
