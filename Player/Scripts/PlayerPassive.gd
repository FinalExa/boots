class_name PlayerPassive
extends Node2D

@export var passiveProcs: Array[ExecuteAttack]

func ActivatePassive(tier: int, objRef: Node2D):
	pass

func GetSpeedIndex(index: int):
	if (index == 0):
		return 0
	return index - 1
