class_name AttackHitbox
extends Area2D

var hitTargets: Array[Node2D]
var characterRef: Node2D

func _ready():
	AttackEnd()

func AttackEnd():
	hitTargets.clear()
