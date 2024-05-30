class_name Projectile
extends CharacterBody2D

@export var movementSpeed: float
@export var rotationOffset: float
@export var lifeTime: float
@export var forward: Node2D

func _physics_process(delta):
	velocity = movementSpeed * self.global_position.direction_to(forward.global_position)
	var collisionCheck: bool = move_and_slide()
	if (collisionCheck):
		DeleteSelf()

func _process(delta):
	LifeTime(delta)

func LifeTime(delta):
	if (lifeTime > 0):
		lifeTime -= delta
	else :
		DeleteSelf()

func DeleteSelf():
	get_parent().remove_child(self)
