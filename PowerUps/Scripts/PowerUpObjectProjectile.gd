class_name PowerUpObjectProjectile
extends Projectile

@export var powerUpObjectRef: PowerUpObjects
@export var alternativeDestroyOutcome: bool
@export var ignoreEnemies: bool

func DeleteSelf():
	if (!alternativeDestroyOutcome):
		if (get_parent() != null):
			get_parent().remove_child(self)
			queue_free()
	else:
		powerUpObjectRef.AlternativeOutcome()

func ProjectileMovement(direction: Vector2):
	velocity = movementSpeed * self.global_position.direction_to(direction)
	var collisionCheck: bool = move_and_slide()
	if (collisionCheck && !ignoreEnemies):
		call_deferred("DeleteSelf")

func CheckForBodies(body):
	if (!(body is EnemyController) && !(body is PlayerCharacter)):
		call_deferred("DeleteSelf")
