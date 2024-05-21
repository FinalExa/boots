extends AttackHitbox

@export var reducedSpeed: float

func _on_body_entered(body):
	if (body is PlayerCharacter):
		if (!hitTargets.has(body)):
			hitTargets.push_back(body)
			CheckForPlayerKill(body)

func CheckForPlayerKill(playerRef: PlayerCharacter):
	if (playerRef.playerMovements.currentSpeed < playerRef.playerMovements.killSpeedValue):
		get_tree().reload_current_scene()
	else:
		playerRef.playerMovements.UpdateCurrentSpeed(-reducedSpeed)
