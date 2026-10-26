extends PlayerPassive

signal passive_launched

func ActivatePassive(tier: int, passiveObj: PlayerPassiveObject):
	passiveObj.OffBehaviour()
	passiveProcs[GetSpeedIndex(tier)].StartAttack()
	emit_signal("passive_launched")
