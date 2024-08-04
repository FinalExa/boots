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

func SetToBase():
	SetCurrentShootingSettings(baseMaxProjectiles, baseProjectileICD, baseProjectilePrefabPath)

func SetCurrentShootingSettings(maxProj: int, icd: float, path: String):
	currentMaxProjectiles = maxProj
	currentProjectiles = currentMaxProjectiles
	currentProjectileICD = icd
	projectileRechargeTimer = 0
	projectileSpawner.objectPath = path
