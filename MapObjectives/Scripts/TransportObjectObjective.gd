class_name TransportObjectObjective
extends MapObjective

@export var transportObjectSpawner: ObjectSpawner
@export var transportDestinations: Array[TransportDestination]
@export var enemySpawnArrays: Array[MultipleObjectSpawner]
var transportObject: TransportObject
var completedDestinations: Array[TransportDestination]

func ReadyOperations():
	GenerateTransportObject()
	RegisterDestinations()

func RegisterDestinations():
	for i in transportDestinations.size():
		transportDestinations[i].mapObjective = self

func GenerateTransportObject():
	if (transportObject == null && transportObjectSpawner != null):
		transportObject = transportObjectSpawner.SpawnObject()

func SetDestinationCompleted(destinationToComplete: TransportDestination):
	if (!completedDestinations.has(destinationToComplete)):
		completedDestinations.push_back(destinationToComplete)
