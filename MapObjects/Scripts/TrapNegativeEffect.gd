extends PassiveNegativeEffect

@export var duration: float
@export var animatedSpriteRef: AnimatedSprite2D
@export var centerPoint: Node2D
var capturedPlayer: bool
var playerInCycle: bool
var timer: float

func _process(delta):
	CaptureTimer(delta)
	EffectAvailable(delta)

func CaptureTimer(delta):
	if (capturedPlayer):
		if (timer > 0):
			timer -= delta
			return
		ReleasePlayer()

func ExecuteEffect(_delta):
	if (!playerInCycle):
		CapturePlayer()

func CapturePlayer():
	capturedPlayer = true
	timer = duration
	playerInCycle = true
	playerRef.playerMovements.AddStopper(self)
	playerRef.global_position = centerPoint.global_position
	animatedSpriteRef.play("capture")

func ReleasePlayer():
	animatedSpriteRef.play("default")
	playerRef.playerMovements.RemoveStopper(self)
	capturedPlayer = false

func PlayerOut(body):
	if (body is PlayerCharacter):
		playerRef = null
		playerInCycle = false
