class_name AttackHitbox
extends Area2D

var collisionShape: CollisionShape2D
var collisionPolygon: CollisionPolygon2D
var hitTargets: Array[Node2D]
var characterRef: Node2D

func _ready():
	GetCollision()
	AttackEnd()

func AttackEnd():
	hitTargets.clear()

func GetCollision():
	for i in self.get_child_count():
		if (self.get_child(i) is CollisionShape2D):
			collisionShape = self.get_child(i)
			break
		if (self.get_child(i) is CollisionPolygon2D):
			collisionPolygon = self.get_child(i)

func Disable():
	self.hide()
	if (collisionShape != null): collisionShape.disabled = true
	if (collisionPolygon != null): collisionPolygon.disabled = true

func Enable():
	self.show()
	if (collisionShape != null): collisionShape.disabled = false
	if (collisionPolygon != null): collisionPolygon.disabled = false
