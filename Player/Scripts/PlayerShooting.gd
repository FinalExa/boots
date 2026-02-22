class_name PlayerShooting
extends Node2D

@export var playerInputs: PlayerInputs
@export var playerSpeedThresholds: PlayerSpeedThresholds
@export var powerUpManager: PowerUpManager
@export var projectileSpawner: ObjectSpawner

@export var baseMaxProjectiles: int
@export var baseProjectileICD: float
@export var baseProjectilePrefabPath: String
@export var projectileTextureBar: TextureProgressBar
@export var projectileCountLabel: Label

var currentMaxProjectiles: int
var currentProjectiles: int
var currentProjectileICD: float
var projectileRechargeTimer: float
var isPowerUp: bool

func _ready():
	SetToBase()
	projectileSpawner.objectPath = baseProjectilePrefabPath
	UpdateUI()
	projectileTextureBar.value = 0

func _process(delta):
	ShootProjectiles()
	ProjectileRechargeCooldown(delta)

func SetToBase():
	SetCurrentShootingSettings(baseMaxProjectiles, baseProjectileICD, false)

func Refull():
	currentProjectiles = currentMaxProjectiles
	projectileRechargeTimer = currentProjectileICD

func SetCurrentShootingSettings(maxProj: int, icd: float, powerUp: bool):
	currentMaxProjectiles = maxProj
	currentProjectiles = currentMaxProjectiles
	currentProjectileICD = icd
	projectileRechargeTimer = currentProjectileICD
	isPowerUp = powerUp
	UpdateUI()
	projectileTextureBar.value = 0

func SetAndShoot(path: String):
	projectileSpawner.objectPath = path
	return projectileSpawner.SpawnObject()

func ShootProjectiles():
	if (currentProjectiles > 0 && playerInputs.shootInput):
		var projectile = GetProjectile()
		if (isPowerUp && projectile is PowerUpObjectProjectile):
			powerUpManager.shootPowerUp.InitializePowerUpObject(projectile.powerUpObjectRef)
		currentProjectiles -= 1

func GetProjectile():
	var projectile
	if (powerUpManager.shootPowerUp != null):
		if (playerSpeedThresholds.speedIndex == 0 || playerSpeedThresholds.speedIndex == 1):
			projectile = SetAndShoot(powerUpManager.shootPowerUp.shootObjectPath1)
		else:
			if (playerSpeedThresholds.speedIndex == 2):
				projectile = SetAndShoot(powerUpManager.shootPowerUp.shootObjectPath2)
			else:
				if (playerSpeedThresholds.speedIndex == 3):
					projectile = SetAndShoot(powerUpManager.shootPowerUp.shootObjectPath3)
	else:
		projectile = SetAndShoot(baseProjectilePrefabPath)
	return projectile

func ProjectileRechargeCooldown(delta):
	if (currentProjectiles < currentMaxProjectiles):
		if (projectileRechargeTimer > 0):
			projectileRechargeTimer -= delta
		else:
			currentProjectiles += 1
			projectileRechargeTimer = currentProjectileICD
		UpdateUI()
		return
	if (projectileTextureBar.value != 0): projectileTextureBar.value = 0

func UpdateUI():
	projectileTextureBar.max_value = currentProjectileICD * 100
	projectileTextureBar.value = projectileRechargeTimer * 100
	projectileCountLabel.text = str(currentProjectiles, "/", currentMaxProjectiles)
