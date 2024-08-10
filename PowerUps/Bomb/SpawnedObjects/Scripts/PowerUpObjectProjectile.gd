class_name PowerUpObjectProjectile
extends Projectile

@export var powerUpObjectRef: PowerUpObjects
@export var alternativeDestroyOutcome: bool

func DeleteSelf():
	if (!alternativeDestroyOutcome):
		if (get_parent() != null):
			get_parent().remove_child(self)
			queue_free()
	else:
		powerUpObjectRef.AlternativeOutcome()
