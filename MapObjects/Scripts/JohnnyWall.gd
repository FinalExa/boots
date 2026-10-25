class_name JohnnyWall
extends PlayerPassiveObject

@export var regenerates: bool
@export var regenerationTimer: float
@export var spriteRef: Sprite2D
@export var collisionRef: CollisionShape2D
var timer: float
var deactivated: bool

func _process(delta):
	RegenerationTimer(delta)

func PlayerPasses(playerRef: PlayerCharacter):
	if (!deactivated):
		playerRef.playerPassive.ActivatePassive(playerRef.playerSpeedThresholds.speedIndex, self)
		if (!regenerates):
			DestroySelf()
		else:
			call_deferred("SetOff")

func DestroySelf():
	self.queue_free()

func SetOff():
	deactivated = true
	timer = regenerationTimer
	spriteRef.hide()
	collisionRef.disabled = true

func SetOn():
	deactivated = false
	spriteRef.show()
	collisionRef.disabled = false

func RegenerationTimer(delta):
	if (deactivated):
		if (timer > 0):
			timer -= delta
			return
		call_deferred("SetOn")
