class_name TransportObject
extends Area2D

var playerIsIn: bool
var playerRef: PlayerCharacter
var isAttachedToPlayer: bool
var originalParent: Node2D

func _ready():
	originalParent = self.get_parent()

func _process(_delta):
	AttachToPlayer()

func AttachToPlayer():
	if (playerIsIn && playerRef != null):
		isAttachedToPlayer = true
		reparent(playerRef.followItem)
		global_position = playerRef.followItem.global_position

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

func _on_body_exited(body):
	if (!isAttachedToPlayer && body is PlayerCharacter && playerIsIn):
		playerIsIn = false
		playerRef = null
