class_name TransportObject
extends Area2D

var playerIsIn: bool
var playerRef: PlayerCharacter
var isAttachedToPlayer: bool
var originalParent: Node2D
var healthValue: int

func _ready():
	originalParent = self.get_parent()

func _process(_delta):
	AttachToPlayer()
	CheckForHealth()

func AttachToPlayer():
	if (playerIsIn && playerRef != null && !isAttachedToPlayer):
		isAttachedToPlayer = true
		reparent(playerRef.followItem)
		global_position = playerRef.followItem.global_position

func CheckForHealth():
	if (isAttachedToPlayer):
		if (playerRef.playerHealth.currentHealth > healthValue):
			healthValue = playerRef.playerHealth.currentHealth
		if (playerRef.playerHealth.currentHealth < healthValue):
			ResetOnDamage()

func ResetOnDamage():
	var objective: TransportObjectObjective = get_tree().root.get_child(0).sceneSelector.currentScene.objective
	objective.call_deferred("GenerateTransportObject")

func DetachFromPlayer():
	if (isAttachedToPlayer):
		isAttachedToPlayer = false
		reparent(originalParent)

func SelfDestruct():
	DetachFromPlayer()
	queue_free()

func _on_body_entered(body):
	if (body is PlayerCharacter && !playerIsIn):
		playerIsIn = true
		playerRef = body
		healthValue = playerRef.playerHealth.currentHealth

func _on_body_exited(body):
	if (!isAttachedToPlayer && body is PlayerCharacter && playerIsIn):
		playerIsIn = false
		playerRef = null
