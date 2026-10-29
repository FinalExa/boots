class_name JohnnyPassiveObject
extends PlayerPassiveObject

@export var regenerates: bool
@export var regenerationTimer: float
@export var deploys: bool
@export var deployTimer: float
@export var spriteRef: Sprite2D
@export var collisionRef: CollisionShape2D
var timer: float
var deployed: bool
var deactivated: bool

func ReadyOperations():
	SetDeploy()

func ProcessOperations(delta):
	DeployTimer(delta)
	RegenerationTimer(delta)

func PlayerPasses():
	if (!deactivated && deployed):
		playerRef.playerPassive.ActivatePassive(playerRef.playerSpeedThresholds.speedIndex, self)

func OffBehaviour():
	if (!regenerates):
		DestroySelf()
	else:
		SetOff()

func DestroySelf():
	self.queue_free()

func SetDeploy():
	if (!deploys):
		deployed = true
	else:
		timer = deployTimer

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

func DeployTimer(delta):
	if (deploys && !deployed):
		if (timer > 0):
			timer -= delta
			return
		deployed = true
