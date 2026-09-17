class_name Fire
extends PowerUpObjects

@export var trueDamage: float
@export var appliesDOT: bool
@export var DOTRef: String = "res://PowerUps/Fire/SpawnedObjects/fire_dot.tscn"
@export var DOT: float
@export var DOTDuration: float
@export var stationary: bool
@export var stationaryDOT: float
@export var stationaryPermanent: bool
@export var stationaryDuration: float
@export var stationaryAreaCollisionShape: CollisionShape2D
@export var sprite: AnimatedSprite2D
var didDamage: bool
var stationaryStarted: bool
var enemiesInRange: Array[EnemyController]
var timer: float
var currentDamage: float
var currentDOT: float
var currentStationaryDOT: float
var currentDOTDuration: float
var currentStationaryDuration: float
var currentStationaryAreaSize: Vector2
var currentSpriteSize: Vector2

func _ready():
	self.global_rotation = 0

func _process(delta):
	ApplyDOT()
	DoDamage()
	if (stationary):
		StartStationary()
		StationaryDamage(delta)
		if (!stationaryPermanent): StationaryTimer(delta)

func IncreaseStats(dataBlock: PowerUpPassiveDataBlock):
	currentDamage = (trueDamage * (dataBlock.damageBonus / 100))
	currentDOT = (DOT * (dataBlock.damageBonus / 100))
	currentStationaryDOT = (stationaryDOT * (dataBlock.damageBonus / 100))
	currentDOTDuration = (DOTDuration * (dataBlock.timeBonus / 100))
	currentStationaryDuration = (stationaryDuration * (dataBlock.timeBonus / 100))
	if (stationaryAreaCollisionShape != null):
		currentStationaryAreaSize = (stationaryAreaCollisionShape.scale * (dataBlock.sizeBonus / 100))
	if (sprite != null):
		currentSpriteSize = (sprite.scale * (dataBlock.sizeBonus / 100))
	SpawnSpecialObjects(dataBlock.specialEffects)

func Finalize():
	if (stationaryAreaCollisionShape != null):
		stationaryAreaCollisionShape.scale = currentStationaryAreaSize
	if (sprite != null):
		sprite.scale = currentSpriteSize

func DoDamage():
	if (currentDamage > 0 && !didDamage && ref != null && ref is EnemyController):
		ref.ReceiveDamage(currentDamage, 0, Vector2.ZERO, 0)
		didDamage = true
		if (!stationary):
			call_deferred("DeleteSelf")

func ApplyDOT():
	if (appliesDOT):
		if (ref != null && ref is EnemyController):
			ref.SetEffectOverTime(SpawnDoT())
		if (enemiesInRange.size() > 0):
			for i in enemiesInRange.size():
				enemiesInRange[i].SetEffectOverTime(SpawnDoT())

func SpawnDoT():
	var obj_scene = load(DOTRef)
	var obj: FireDoT = obj_scene.instantiate()
	obj.duration = currentDOTDuration
	obj.damage = currentDOT
	obj.source = powerUpRef
	return obj

func StartStationary():
	if (!stationaryStarted):
		timer = stationaryDuration
		stationaryStarted = true

func StationaryTimer(delta):
	if (timer > 0):
		timer -= delta
	if (timer <= 0):
		call_deferred("DeleteSelf")

func StationaryDamage(delta):
	for i in enemiesInRange.size():
		enemiesInRange[i].enemyHealth.HealthUpdate(-currentStationaryDOT * delta)

func ObjectInArea(body):
	if (body is EnemyController && !enemiesInRange.has(body)):
		enemiesInRange.push_back(body)

func ObjectOutOfArea(body):
	if (body is EnemyController && enemiesInRange.has(body)):
		enemiesInRange.erase(body)
