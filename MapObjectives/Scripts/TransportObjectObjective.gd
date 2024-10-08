class_name TransportObjectObjective
extends MapObjective

@export var transportObjectSpawner: ObjectSpawner
@export var transportDestinations: Array[TransportDestination]
var transportObject: TransportObject

func ReadyOperations():
	GenerateTransportObject()
	RegisterDestinations()

func RegisterDestinations():
	for i in transportDestinations.size():
		transportDestinations[i].mapObjective = self

func GenerateTransportObject():
	if (transportObject == null && transportObjectSpawner != null):
		transportObject = transportObjectSpawner.SpawnObject()
