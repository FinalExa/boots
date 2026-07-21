class_name PlayerShooting
extends Node2D

signal enemyHit

@export var playerInputs: PlayerInputs
@export var playerSpeedThresholds: PlayerSpeedThresholds
@export var powerUpManager: PowerUpManager
@export var projectileSpawner: ObjectSpawner

@export var baseMaxProjectiles: int
@export var baseProjectileReloadTime: float
@export var baseProjectileShootDelay: float
@export var baseProjectilePaths: Array[String]
@export var projectileTextureBar: TextureProgressBar
@export var projectileCountLabel: Label

var currentMaxProjectiles: int
var currentProjectiles: int
var currentProjectileReloadTime: float
var currentProjectileShootDelay: float
var projectileReloadTimer: float
var projectileDelayTimer: float
var isPowerUp: bool

func _ready():
	SetToBase()
	UpdateUI()
	projectileTextureBar.value = 0

func _process(delta):
	ShootProjectiles()
	ManualReload()
	ShootDelay(delta)
	ProjectileRechargeCooldown(delta)

func SetToBase():
	SetCurrentShootingSettings(baseMaxProjectiles, baseProjectileReloadTime, baseProjectileShootDelay)

func Refull():
	currentProjectiles = currentMaxProjectiles
	projectileReloadTimer = currentProjectileReloadTime

func SetCurrentShootingSettings(maxProj: int, icd: float, delay: float):
	currentMaxProjectiles = maxProj
	currentProjectiles = currentMaxProjectiles
	currentProjectileReloadTime = icd
	projectileReloadTimer = 0
	currentProjectileShootDelay = delay
	projectileDelayTimer = 0
	UpdateUI()
	projectileTextureBar.value = 0

func SetAndShoot(path: String):
	projectileSpawner.objectPath = path
	var projectile: PlayerProjectile = projectileSpawner.SpawnObject()
	projectile.playerShooting = self
	return

func ShootProjectiles():
	if (currentProjectiles > 0 && projectileDelayTimer <= 0 && playerInputs.shootInput):
		GetProjectile()
		currentProjectiles -= 1
		if (currentProjectiles == 0):
			projectileReloadTimer = currentProjectileReloadTime
		else:
			projectileDelayTimer = currentProjectileShootDelay
		UpdateUI()

func GetProjectile():
	if (playerSpeedThresholds.speedIndex <= 1):
		SetAndShoot(baseProjectilePaths[0])
		return
	if (playerSpeedThresholds.speedIndex == 2):
		SetAndShoot(baseProjectilePaths[1])
		return
	if (playerSpeedThresholds.speedIndex == 3):
		SetAndShoot(baseProjectilePaths[2])
		return

func ProjectileRechargeCooldown(delta):
	if (currentProjectiles == 0):
		if (projectileReloadTimer > 0):
			projectileReloadTimer -= delta
		else:
			Refull()
		UpdateUI()
		return
	if (projectileTextureBar.value != 0): projectileTextureBar.value = 0

func ShootDelay(delta):
	if (projectileDelayTimer > 0):
		projectileDelayTimer -= delta
		return

func ManualReload():
	if (playerInputs.reloadInput && currentProjectiles < currentMaxProjectiles):
		projectileDelayTimer = 0
		currentProjectiles = 0
		projectileReloadTimer = currentProjectileReloadTime

func EnemyHit(enemyRef: EnemyController):
	emit_signal("enemyHit", enemyRef)

func UpdateUI():
	projectileTextureBar.max_value = currentProjectileReloadTime * 100
	projectileTextureBar.value = projectileReloadTimer * 100
	projectileCountLabel.text = str(currentProjectiles, "/", currentMaxProjectiles)
