class_name EnemySideShield
extends Area2D

@export var characterRef: CharacterBody2D
@export var timeOff: float
var offTimer: float
var isActive: bool

func _ready():
	TurnOn()

func _process(delta):
	OffTimer(delta)

func OffTimer(delta):
	if (!isActive):
		if (offTimer > 0):
			offTimer -= delta
		else:
			TurnOn()

func TurnOn():
	self.show()
	isActive = true

func TurnOff():
	offTimer = timeOff
	self.hide()
	isActive = false
