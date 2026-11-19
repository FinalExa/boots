class_name PassiveNegativeEffect
extends Node2D

var negativeEffectActive: bool
var playerRef: PlayerCharacter

func _ready():
	ReadyOperations()

func ReadyOperations():
	pass

func SetEnabled():
	negativeEffectActive = true

func SetDisabled():
	negativeEffectActive = false

func PlayerIn(body):
	if (body is PlayerCharacter):
		playerRef = body

func PlayerOut(body):
	if (body is PlayerCharacter):
		playerRef = null

func EffectAvailable(delta):
	if (playerRef != null && negativeEffectActive):
		ExecuteEffect(delta)

func ExecuteEffect(_delta):
	pass
