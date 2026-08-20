class_name EnemyProjectile
extends Projectile

@export var speedDecrease: float
@export var collisionSound: AudioStreamPlayer

func CheckForBodies(body):
	if (body is PlayerCharacter):
		DecreasePlayerSpeed(body)

func DecreasePlayerSpeed(playerCharacter: PlayerCharacter):
	if (!playerCharacter.playerHealth.invulnerabilityActive):
		collisionSound.play()
		playerCharacter.playerHealth.CheckForDamageType(damage)
		playerCharacter.playerMovements.UpdateCurrentSpeed(-speedDecrease)
	call_deferred("DeleteSelf")
