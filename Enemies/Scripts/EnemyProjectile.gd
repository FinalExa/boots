extends Projectile

func _on_projectile_area_body_entered(body):
	if (body is PlayerCharacter):
		DecreasePlayerSpeed(body)

func DecreasePlayerSpeed(playerCharacter: PlayerCharacter):
	if (!playerCharacter.playerHealth.invulnerabilityActive):
		collisionSound.play()
		playerCharacter.playerHealth.CheckForDamageType(fullDamage, partialDamage)
		playerCharacter.playerMovements.UpdateCurrentSpeed(-speedDecrease)
	call_deferred("DeleteSelf")
