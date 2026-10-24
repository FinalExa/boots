extends PlayerPassive

signal passive_launched

func ActivatePassive(tier: int, objRef: Node2D):
	passiveProcs[GetSpeedIndex(tier)].StartAttack()
	emit_signal("passive_launched")
