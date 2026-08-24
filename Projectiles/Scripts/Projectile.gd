class_name Projectile
extends CharacterBody2D

@export var movementSpeed: float
@export var rotationOffset: float = 90
@export var lifeTime: float
@export var forward: Node2D
@export var damage: float
@export var endOnCollisionOverride: bool

func _ready():
	ReadyOperations()

func _physics_process(_delta):
	SetVelocity(forward.global_position)
	ProjectileMovement()

func _process(delta):
	LifeTime(delta)

func SetVelocity(direction: Vector2):
	velocity = movementSpeed * self.global_position.direction_to(direction)

func ProjectileMovement():
	var collisionCheck: bool = move_and_slide()
	if (collisionCheck && !endOnCollisionOverride):
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

func ReadyOperations():
	pass

func CheckForBodies(_body):
	pass

func CheckForAreas(_area):
	pass
