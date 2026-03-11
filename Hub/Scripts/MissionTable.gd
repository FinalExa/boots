class_name MissionTable
extends StaticBody2D

@export var activeLevelPath: String
@export var inputIcon: AnimatedSprite2D
var controllerAnimation: bool
var playerHubRef: PlayerHub

func _ready():
	inputIcon.hide()

func _process(_delta):
	WaitForInput()

func WaitForInput():
	if (playerHubRef != null):
		if (!playerHubRef.playerInputs.controller && controllerAnimation):
			controllerAnimation = false
			inputIcon.play("keyboard")
		else:
			if (playerHubRef.playerInputs.controller && !controllerAnimation):
				controllerAnimation = true
				inputIcon.play("controller")
		if (playerHubRef.playerInputs.interactionInput):
			call_deferred("StartMission")

func StartMission():
	var rootRef = get_tree().root
	var hubRef = rootRef.get_child(0)
	rootRef.remove_child(hubRef)
	var obj_scene = load(activeLevelPath)
	var sceneMaster: SceneMaster = obj_scene.instantiate()
	sceneMaster.sceneSelector.playerRef.global_position = sceneMaster.sceneSelector.safePosition
	rootRef.add_child(sceneMaster)
	hubRef.queue_free()

func PlayerIn(body):
	if (body is PlayerHub):
		inputIcon.show()
		playerHubRef = body

func PlayerOut(body):
	if (body is PlayerHub):
		inputIcon.hide()
		playerHubRef = null
