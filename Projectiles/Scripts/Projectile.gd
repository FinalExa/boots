class_name Projectile
extends CharacterBody2D

@export var movementSpeed: float
@export var rotationOffset: float = 90
@export var lifeTime: float
@export var forward: Node2D
@export var damage: float


func _physics_process(_delta):
	ProjectileMovement(forward.global_position)

func _process(delta):
	LifeTime(delta)

func ProjectileMovement(direction: Vector2):
	velocity = movementSpeed * self.global_position.direction_to(direction)
	var collisionCheck: bool = move_and_slide()
	if (collisionCheck):
		call_deferred("DeleteSelf")

func LifeTime(delta):
	if (lifeTime > 0):
		lifeTime -= delta
	else :
		call_deferred("DeleteSelf")

func DeleteSelf():
	if (get_parent() != null):
		get_parent().remove_child(self)
		queue_free()

func CheckForBodies(_body):
	pass

func CheckForAreas(_area):
	pass
