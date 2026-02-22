class_name PowerUpAbility
extends PowerUp

@export var abilitySpawners1: Array[ObjectSpawner]
@export var abilitySpawners2: Array[ObjectSpawner]
@export var abilitySpawners3: Array[ObjectSpawner]
@export var secondAbilitySlot: bool

func ActivateAbilityPowerUp(index: int):
	if (index == 1): LaunchSpawners(abilitySpawners1)
	else:
		if (index == 2): LaunchSpawners(abilitySpawners2)
		else:
			if (index == 3): LaunchSpawners(abilitySpawners3)
