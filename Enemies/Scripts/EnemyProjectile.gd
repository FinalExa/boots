class_name EnemyProjectile
extends Projectile

@export var speedDecrease: float
@export var collisionSound: AudioStreamPlayer
@export var directDamage: bool
@export var chasePlayer: bool
var player: PlayerCharacter

func ReadyOperations():
	if (chasePlayer):
		player = get_tree().root.get_child(0).sceneSelector.playerRef

func _physics_process(_delta):
	if (chasePlayer): SetVelocity(player.global_position)
	else: SetVelocity(forward.global_position)
	ProjectileMovement()

func CheckForBodies(body):
	if (body is PlayerCharacter):
		DecreasePlayerSpeed(body)

func DecreasePlayerSpeed(playerCharacter: PlayerCharacter):
	if (!playerCharacter.playerHealth.invulnerabilityActive):
		collisionSound.play()
		if (directDamage): playerCharacter.playerHealth.LoseHeart()
		else: playerCharacter.playerHealth.CheckForDamageType(damage)
		playerCharacter.playerMovements.UpdateCurrentSpeed(-speedDecrease)
	call_deferred("DeleteSelf")
