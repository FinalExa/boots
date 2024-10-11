class_name TransportDestination
extends Node2D

var mapObjective: TransportObjectObjective
var playerIsIn: bool
var playerRef: PlayerCharacter
var completed: bool

func SetCompleted(transportObject: TransportObject):
	completed = true
	transportObject.DetachFromPlayer()
	mapObjective.SetDestinationCompleted(self)
	
func _on_area_2d_body_entered(body):
	if (body is PlayerCharacter && !playerIsIn):
		playerIsIn = true
		playerRef = body
		if (!completed && playerRef.followItem.get_child(0) is TransportObject):
			SetCompleted(playerRef.followItem.get_child(0))

func _on_area_2d_body_exited(body):
	if (body is PlayerCharacter && playerIsIn):
		playerIsIn = false
		playerRef = null
