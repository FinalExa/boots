class_name EnemyProjectile
extends Projectile

@export var speedDecrease: float
@export var partialDamage: float
@export var collisionSound: AudioStreamPlayer

func _on_projectile_area_body_entered(body):
	if (body is PlayerCharacter):
		DecreasePlayerSpeed(body)

func DecreasePlayerSpeed(playerCharacter: PlayerCharacter):
	if (!playerCharacter.playerHealth.invulnerabilityActive):
		collisionSound.play()
		playerCharacter.playerHealth.CheckForDamageType(damage, partialDamage)
		playerCharacter.playerMovements.UpdateCurrentSpeed(-speedDecrease)
	call_deferred("DeleteSelf")
