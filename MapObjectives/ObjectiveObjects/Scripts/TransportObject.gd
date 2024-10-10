class_name TransportObject
extends Node2D

var playerIsIn: bool
var playerRef: PlayerCharacter
var isAttachedToPlayer: bool
var activateOnPlayerClose: Node2D
var originalParent: Node2D

func _ready():
	originalParent = self.get_parent()
	activateOnPlayerClose.hide()

func _process(_delta):
	AttachToPlayer()

func AttachToPlayer():
	if (playerIsIn && playerRef != null && playerRef.playerInputs.interactionInput):
		isAttachedToPlayer = true
		playerRef.followItem.add_child(self)

func DetachFromPlayer():
	if (isAttachedToPlayer):
		isAttachedToPlayer = false
		originalParent.add_child(self)

func _on_area_2d_body_entered(body):
	if (body is PlayerCharacter && !playerIsIn):
		activateOnPlayerClose.show()
		playerIsIn = true
		playerRef = body

func _on_area_2d_body_exited(body):
	if (!isAttachedToPlayer && body is PlayerCharacter && playerIsIn):
		activateOnPlayerClose.hide()
		playerIsIn = false
		playerRef = null
