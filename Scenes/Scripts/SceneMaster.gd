class_name SceneMaster
extends Node2D

@export var frameMaster: FrameMaster
@export var sceneSelector: SceneSelector

func _ready():
	if (get_tree().paused):
		get_tree().paused = false
