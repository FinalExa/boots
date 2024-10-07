class_name TransportObjectObjective
extends MapObjective

@export var transportObjectSpawner: ObjectSpawner
@export var transportDestinations: Array[TransportDestination]

func ReadyOperations():
	RegisterDestinations()

func RegisterDestinations():
	for i in transportDestinations.size():
		transportDestinations[i].mapObjective = self
