extends PassiveNegativeEffect

@export var baseObject: Node2D
@export var minDistance: float
@export var attractionForce: float
@export var activeDuration: float
@export var inactiveDuration: float
var activated: bool
var timer: float

func _process(delta):
	ActivationTimer(delta)
	EffectAvailable(delta)

func ExecuteEffect(delta):
	if (activated && playerRef.global_position.distance_to(baseObject.global_position) > minDistance):
		playerRef.translate(playerRef.global_position.direction_to(baseObject.global_position) * attractionForce * delta)

func ActivationTimer(delta):
	if (timer > 0):
		timer -= delta
		return
	if (activated):
		TurnOff()
		return
	TurnOn()

func TurnOff():
	timer = inactiveDuration + timer
	activated = false
	self.hide()

func TurnOn():
	timer = activeDuration + timer
	activated = true
	self.show()
