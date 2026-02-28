class_name TargetPointer
extends VisibleOnScreenNotifier2D

@export var baseObjectRef: Node2D
@export var rotator: Node2D
@export var sprite: AnimatedSprite2D
@export var distanceFromRotator: float
@export var offset: float = 90
var playerRef: PlayerCharacter
var separated: bool
var onScreen: bool
var active: bool
var basePosition: Vector2
var baseRotation: float

func _ready():
	if (!active):
		rotator.hide()
	basePosition = self.position
	baseRotation = rotator.rotation_degrees
	playerRef = get_tree().root.get_child(0).sceneSelector.playerRef

func _process(_delta):
	SetPosition()

func Activate():
	active = true
	rotator.show()

func SetPosition():
	if (active && rotator != null):
		if (!onScreen):
			AttachToPlayer()
		else:
			AttachToEnemy()

func AttachToEnemy():
	if (separated):
		rotator.reparent(self)
		rotator.position = basePosition
		sprite.position = Vector2.ZERO
		rotator.rotation_degrees = baseRotation
		separated = false

func AttachToPlayer():
	if (!separated):
		rotator.reparent(playerRef)
		rotator.global_position = playerRef.global_position
		sprite.position.y = -distanceFromRotator
		separated = true
	rotator.look_at(baseObjectRef.global_position)
	rotator.rotation_degrees += offset

func _on_screen_entered():
	onScreen = true

func _on_screen_exited():
	onScreen = false

func DestroyRotator():
	rotator.queue_free()
