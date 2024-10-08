class_name TransportObject
extends Node2D

var playerIsIn: bool
var playerRef: PlayerCharacter
var isAttachedToPlayer: bool

func _on_area_2d_body_entered(body):
	if (body is PlayerCharacter && !playerIsIn):
		playerIsIn = true
		playerRef = body

func _on_area_2d_body_exited(body):
	if (!isAttachedToPlayer && body is PlayerCharacter && playerIsIn):
		playerIsIn = false
		playerRef = null
