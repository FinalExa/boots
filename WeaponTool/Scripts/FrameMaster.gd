class_name FrameMaster
extends Node

var attackSources: Array[ExecuteAttack]
var nullIndexes: Array[int]

@export var framesPerSecond: float
var frameTime: float
var frameTimer: float

func _ready():
	frameTime = 1 / framesPerSecond
	frameTimer = 0

func _process(delta):
	FrameTimer(delta)

func FrameTimer(delta):
	if (attackSources.size() > 0):
		frameTimer += delta
		if (frameTimer >= frameTime):
			PrepareLaunchFrame(delta)

func PrepareLaunchFrame(delta):
	frameTimer -= frameTime
	LaunchFrame()
	if (frameTimer >= frameTime):
		PrepareLaunchFrame(delta)

func LaunchFrame():
	for i in attackSources.size():
		if (i >= attackSources.size()):
			break
		if (attackSources[i] != null):
			attackSources[i].Attacking()
		else:
			attackSources.remove_at(i)
			i -= 1

func RegisterAttack(attack: ExecuteAttack):
	attackSources.push_back(attack)

func RemoveAttack(attack: ExecuteAttack):
	attackSources.erase(attack)
