class_name IceThorn
extends Area2D

var damage: float
var timer: float
var enemiesInRange: Array[EnemyController]

func Initialize(receivedDamage: float, receivedDuration: float):
	damage = receivedDamage
	timer = receivedDuration

func _process(delta):
	CheckForExplosion()
	ThornTimer(delta)

func ThornTimer(delta):
	if (timer > 0):
		timer -= delta
		return
	Explode()

func CheckForExplosion():
	if (enemiesInRange.size() > 0):
		Explode()

func Explode():
	for i in enemiesInRange.size():
		enemiesInRange[i].DealTrueDamage(damage, 0, Vector2.ZERO, 0, self)
	DeleteSelf()

func DeleteSelf():
	self.queue_free()

func ObjectInArea(body):
	if (body is EnemyController && !enemiesInRange.has(body)):
		enemiesInRange.push_back(body)

func ObjectOutOfArea(body):
	if (body is EnemyController && enemiesInRange.has(body)):
		enemiesInRange.erase(body)
