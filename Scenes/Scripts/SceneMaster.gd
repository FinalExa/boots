class_name SceneMaster
extends Node2D

var savedDeletePaths: Array[String]
var savePath: String
var playerDataSavePath: String = "user://PlayerData.save"
var stopResetPosition: bool

var lastPos: Vector2
var lastTransformationSet: bool
var lastObjectOriginalPath: String

@export var frameMaster: FrameMaster
var playerRef: PlayerCharacter

func _ready():
	if (get_tree().paused):
		get_tree().paused = false
