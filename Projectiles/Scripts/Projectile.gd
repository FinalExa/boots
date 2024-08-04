class_name Projectile
extends CharacterBody2D

@export var movementSpeed: float
@export var rotationOffset: float
@export var lifeTime: float
@export var forward: Node2D
@export var speedDecrease: float
@export var fullDamage: float
@export var partialDamage: float
@export var collisionSound: AudioStreamPlayer

func _physics_process(_delta):
	velocity = movementSpeed * self.global_position.direction_to(forward.global_position)
	var collisionCheck: bool = move_and_slide()
	if (collisionCheck):
		call_deferred("DeleteSelf")

func _process(delta):
	LifeTime(delta)

func LifeTime(delta):
	if (lifeTime > 0):
		lifeTime -= delta
	else :
		call_deferred("DeleteSelf")

func DeleteSelf():
	if (get_parent() != null):
		get_parent().remove_child(self)
		queue_free()

func _on_projectile_area_body_entered(body):
	pass
