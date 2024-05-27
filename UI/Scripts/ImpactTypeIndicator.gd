class_name ImpactTypeIndicator
extends Node2D

@export var textLabel: Label
@export var directText: String
@export var clashText: String
@export var ascendingSpeed: float
@export var lifeTime: float
var lifeTimer: float
var startPos: Vector2

func _ready():
	lifeTimer = lifeTime
	self.global_position = startPos

func Initialize(isClash: bool, position: Vector2):
	startPos = position
	if (!isClash):
		textLabel.text = directText
		return
	textLabel.text = clashText

func _process(delta):
	LifeTimer(delta)

func LifeTimer(delta):
	if (lifeTimer > 0):
		self.global_position.y -= ascendingSpeed * delta
		lifeTimer -= delta
	else:
		call_deferred("EndLifeTimer")

func EndLifeTimer():
	self.get_parent().remove_child(self)
