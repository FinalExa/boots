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
var baseDamage: float
var currentDamage: float
var baseDOT: float
var currentDOT: float
var baseStationaryDOT: float
var currentStationaryDOT: float
var baseDOTDuration: float
var currentDOTDuration: float
var baseStationaryDuration: float
var currentStationaryDuration: float
var baseStationaryAreaSize: Vector2
var currentStationaryAreaSize: Vector2
var baseSpriteSize: Vector2
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

func SetBaseStats():
	baseDamage = trueDamage
	currentDamage = baseDamage
	baseDOT = DOT
	currentDOT = baseDOT
	baseStationaryDOT = stationaryDOT
	currentStationaryDOT = baseStationaryDOT
	baseDOTDuration = DOTDuration
	currentDOTDuration = baseDOTDuration
	baseStationaryDuration = stationaryDuration
	currentStationaryDuration = baseStationaryDuration
	if (stationaryAreaCollisionShape != null):
		baseStationaryAreaSize = stationaryAreaCollisionShape.scale
		currentStationaryAreaSize = baseStationaryAreaSize
	if (sprite != null):
		baseSpriteSize = sprite.scale
		currentSpriteSize = baseSpriteSize

func IncreaseStats(damage: float, size: float, time: float, specialObject: String):
	currentDamage += (baseDamage * (damage / 100))
	currentDOT += (baseDOT * (damage / 100))
	currentStationaryDOT += (baseStationaryDOT * (damage / 100))
	currentDOTDuration += (baseDOTDuration * (time / 100))
	currentStationaryDuration += (baseStationaryDuration * (time / 100))
	if (stationaryAreaCollisionShape != null):
		currentStationaryAreaSize += (baseStationaryAreaSize * (size / 100))
	if (sprite != null):
		currentSpriteSize += (baseSpriteSize * (size / 100))
	SpawnSpecialObject(specialObject)

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
		if (ref != null && ref is EnemyController && ref.currentEffectOverTime == null):
			ref.SetEffectOverTime(SpawnDoT())
		if (enemiesInRange.size() > 0):
			for i in enemiesInRange.size():
				if (enemiesInRange[i].currentEffectOverTime == null):
					enemiesInRange[i].SetEffectOverTime(SpawnDoT())

func SpawnDoT():
	var obj_scene = load(DOTRef)
	var obj: FireDoT = obj_scene.instantiate()
	obj.duration = currentDOTDuration
	obj.damage = currentDOT
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
