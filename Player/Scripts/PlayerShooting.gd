class_name PlayerShooting
extends Node2D

@export var playerInputs: PlayerInputs
@export var projectileSpawner: ObjectSpawner

@export var baseMaxProjectiles: int
@export var baseProjectileICD: float
@export var baseProjectilePrefabPath: String
@export var projectileCountLabel: Label

var currentMaxProjectiles: int
var currentProjectiles: int
var currentProjectileICD: float
var projectileRechargeTimer: float

func _ready():
	SetToBase()
	UpdateLabel()

func _process(delta):
	ShootProjectiles()
	ProjectileRechargeCooldown(delta)

func SetToBase():
	SetCurrentShootingSettings(baseMaxProjectiles, baseProjectileICD, baseProjectilePrefabPath)

func Refull():
	currentProjectiles = currentMaxProjectiles
	projectileRechargeTimer = currentProjectileICD

func SetCurrentShootingSettings(maxProj: int, icd: float, path: String):
	currentMaxProjectiles = maxProj
	currentProjectiles = currentMaxProjectiles
	currentProjectileICD = icd
	projectileRechargeTimer = currentProjectileICD
	projectileSpawner.objectPath = path

func ShootProjectiles():
	if (currentProjectiles > 0 && playerInputs.shootInput):
		projectileSpawner.SpawnObject()
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
