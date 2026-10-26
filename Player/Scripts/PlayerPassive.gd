class_name PlayerPassive
extends Node2D

@export var passiveProcs: Array[ExecuteAttack]

func ActivatePassive(_tier: int, _passiveRef: PlayerPassiveObject):
	pass

func GetSpeedIndex(index: int):
	if (index == 0):
		return 0
	return index - 1
