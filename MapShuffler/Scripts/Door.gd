class_name Door
extends Node2D

@export var activeSprite: Sprite2D
@export var offSprite: Sprite2D
@export var centralCollider: Node2D
@export var endMapArea: String

func _ready():
	StartupDoor()

func StartupDoor():
	offSprite.hide()
	var sceneMaster: SceneMaster = get_tree().root.get_child(0)
	sceneMaster.sceneSelector.currentScene.RegisterDoor(self)

func OpenDoor():
	offSprite.show()
	activeSprite.hide()
	remove_child(centralCollider)
	var obj_scene = load(endMapArea)
	var obj = obj_scene.instantiate()
	add_child(obj)
