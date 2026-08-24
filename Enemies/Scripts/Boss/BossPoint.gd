extends Node2D

@export var bossEnemy: BossController

func _ready():
	bossEnemy.bossRobotMissileCheck.SetMissilePoint(self)
