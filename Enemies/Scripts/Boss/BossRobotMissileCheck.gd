class_name BossRobotMissileCheck
extends Node

@export var missileAttackCooldown: float
@export var pointDistance: float
var missilePoint: Node2D
var missileAttackTimer: float
var missileReady: bool

func _ready():
	StartMissileCooldown()

func _process(delta):
	MissileCooldown(delta)

func SetMissilePoint(point: Node2D):
	missilePoint = point

func StartMissileCooldown():
	missileReady = false
	missileAttackTimer = missileAttackCooldown

func MissileCooldown(delta):
	if (!missileReady):
		if (missileAttackTimer > 0):
			missileAttackTimer -= delta
			return
		missileReady = true
