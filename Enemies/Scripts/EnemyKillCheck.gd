extends AttackHitbox

@export var reducedSpeed: float
@export var hitSound: AudioStreamPlayer

func _on_body_entered(body):
	if (body is PlayerCharacter):
		if (!hitTargets.has(body)):
			hitTargets.push_back(body)
			CheckForPlayerKill(body)

func CheckForPlayerKill(playerRef: PlayerCharacter):
	hitSound.play()
	playerRef.playerMovements.CheckForGameOver()
	playerRef.playerMovements.UpdateCurrentSpeed(-reducedSpeed)
