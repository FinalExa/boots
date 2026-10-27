class_name JohnnyPassiveObject
extends PlayerPassiveObject

@export var regenerates: bool
@export var regenerationTimer: float
@export var spriteRef: Sprite2D
@export var collisionRef: CollisionShape2D
var timer: float
var deactivated: bool

func ProcessOperations(delta):
	RegenerationTimer(delta)

func PlayerPasses(playerRef: PlayerCharacter):
	if (!deactivated):
		playerRef.playerPassive.ActivatePassive(playerRef.playerSpeedThresholds.speedIndex, self)

func OffBehaviour():
	if (!regenerates):
		DestroySelf()
	else:
		SetOff()

func DestroySelf():
	self.queue_free()

func SetOff():
	deactivated = true
	timer = regenerationTimer
	spriteRef.hide()

func SetOn():
	deactivated = false
	spriteRef.show()

func RegenerationTimer(delta):
	if (deactivated):
		if (timer > 0):
			timer -= delta
			return
		call_deferred("SetOn")
