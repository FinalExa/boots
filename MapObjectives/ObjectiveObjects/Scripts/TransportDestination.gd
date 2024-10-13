class_name TransportDestination
extends Node2D

@export var spriteRef: Sprite2D
var mapObjective: TransportObjectObjective
var transportObjectIn: bool
var transportObjectRef: TransportObject
var completed: bool

func SetCompleted(transportObject: TransportObject):
	completed = true
	spriteRef.hide()
	mapObjective.call_deferred("GenerateTransportObject")
	mapObjective.call_deferred("SetDestinationCompleted", self)

func _on_area_2d_area_entered(area):
	if (area is TransportObject && !transportObjectIn):
		transportObjectIn = true
		transportObjectRef = area
		if (!completed):
			SetCompleted(transportObjectRef)

func _on_area_2d_area_exited(area):
	if (area is TransportObject && transportObjectIn):
		transportObjectIn = false
		transportObjectRef = null
