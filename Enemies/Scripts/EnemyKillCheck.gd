extends AttackHitbox

@export var reducedSpeed: float
@export var fullDamage: float
@export var partialDamage: float
@export var hitSound: AudioStreamPlayer

func _on_body_entered(body):
	if (body is PlayerCharacter):
		if (!hitTargets.has(body)):
			hitTargets.push_back(body)
			CheckForPlayerKill(body)

func CheckForPlayerKill(playerRef: PlayerCharacter):
	if (!playerRef.playerHealth.invulnerabilityActive):
		hitSound.play()
		playerRef.playerHealth.CheckForDamageType(fullDamage, partialDamage)
		playerRef.playerMovements.UpdateCurrentSpeed(-reducedSpeed)
