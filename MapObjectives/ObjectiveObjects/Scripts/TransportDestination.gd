class_name TransportDestination
extends Node2D

@export var spriteRef: AnimatedSprite2D
@export var captureArea: CaptureArea
@export var targetPointer: TargetPointer
var mapObjective: TransportObjectObjective
var transportObjectIn: bool
var transportObjectRef: TransportObject
var completed: bool

func SetCompleted():
	completed = true
	spriteRef.hide()
	mapObjective.call_deferred("SetDestinationCompleted", self)
	targetPointer.Deactivate()

func _on_area_2d_area_entered(area):
	if (area is TransportObject && !transportObjectIn):
		transportObjectIn = true
		transportObjectRef = area
		if (!captureArea.areaActive):
			captureArea.Initialize()
			var count: int = 0
			for i in mapObjective.transportDestinations.size():
				if (mapObjective.transportDestinations[i].captureArea.areaActive):
					count += 1
			if (count < mapObjective.transportDestinations.size()):
				mapObjective.call_deferred("GenerateTransportObject")
			else:
				mapObjective.transportObject.call_deferred("SelfDestruct")
			mapObjective.DeactivateUndeliveredDestinationPointers()

func _on_area_2d_area_exited(area):
	if (area is TransportObject && transportObjectIn):
		transportObjectIn = false
		transportObjectRef = null
