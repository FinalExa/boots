extends PlayerPassive

signal passive_launched

func ActivatePassive(tier: int, _objRef: Node2D):
	passiveProcs[GetSpeedIndex(tier)].StartAttack()
	emit_signal("passive_launched")
