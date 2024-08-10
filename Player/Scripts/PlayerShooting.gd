class_name PlayerShooting
extends Node2D

@export var playerInputs: PlayerInputs
@export var powerUpManager: PowerUpManager
@export var projectileSpawner: ObjectSpawner

@export var baseMaxProjectiles: int
@export var baseProjectileICD: float
@export var baseProjectilePrefabPath: String
@export var projectileCountLabel: Label

var shootPowerUp: PowerUp
var currentMaxProjectiles: int
var currentProjectiles: int
var currentProjectileICD: float
var projectileRechargeTimer: float
var isPowerUp: bool

func _ready():
	SetToBase()
	UpdateLabel()

func _process(delta):
	ShootProjectiles()
	ProjectileRechargeCooldown(delta)

func SetToBase():
	SetCurrentShootingSettings(baseMaxProjectiles, baseProjectileICD, baseProjectilePrefabPath, false)

func Refull():
	currentProjectiles = currentMaxProjectiles
	projectileRechargeTimer = currentProjectileICD

func SetCurrentShootingSettings(maxProj: int, icd: float, path: String, powerUp: bool):
	currentMaxProjectiles = maxProj
	currentProjectiles = currentMaxProjectiles
	currentProjectileICD = icd
	projectileRechargeTimer = currentProjectileICD
	projectileSpawner.objectPath = path
	isPowerUp = powerUp

func ShootProjectiles():
	if (currentProjectiles > 0 && playerInputs.shootInput):
		var projectile = projectileSpawner.SpawnObject()
		if (isPowerUp && projectile is PowerUpObjectProjectile):
			powerUpManager.shootPowerUp.InitializePowerUpObject(projectile.powerUpObjectRef)
		currentProjectiles -= 1

func ProjectileRechargeCooldown(delta):
	if (currentProjectiles < currentMaxProjectiles):
		if (projectileRechargeTimer > 0):
			projectileRechargeTimer -= delta
		else:
			currentProjectiles += 1
			projectileRechargeTimer = currentProjectileICD
		UpdateLabel()

func UpdateLabel():
	projectileCountLabel.text = str("Projectiles: ", currentProjectiles, "/", currentMaxProjectiles, "\n", "Projectile recharge cooldown: ", snapped(projectileRechargeTimer, 0.1))
