class_name TransportDestination
extends Node2D

@export var spriteRef: AnimatedSprite2D
@export var captureArea: CaptureArea
var mapObjective: TransportObjectObjective
var transportObjectIn: bool
var transportObjectRef: TransportObject
var completed: bool

func SetCompleted():
	completed = true
	spriteRef.hide()
	mapObjective.call_deferred("SetDestinationCompleted", self)

func _on_area_2d_area_entered(area):
	if (area is TransportObject && !transportObjectIn):
		transportObjectIn = true
		transportObjectRef = area
		if (!captureArea.areaActive):
			captureArea.Initialize()
			mapObjective.call_deferred("GenerateTransportObject")

func _on_area_2d_area_exited(area):
	if (area is TransportObject && transportObjectIn):
		transportObjectIn = false
		transportObjectRef = null
