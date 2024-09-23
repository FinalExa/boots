class_name PlayerAbilities
extends Node2D

@export var playerInputs: PlayerInputs

@export var ability1: ExecuteAttack
@export var ability1Cooldown: float
var ability1Timer: float
@export var ability1Stacks: int = 1
var ability1CurrentStacks: int
@export var ability1Label: Label

@export var ability2: ExecuteAttack
@export var ability2Cooldown: float
var ability2Timer: float
@export var ability2Stacks: int = 1
var ability2CurrentStacks: int
@export var ability2Label: Label

func _ready():
	StartupAbilities()

func _process(delta):
	AbilityIsUsed()
	AbilityCooldowns(delta)

func StartupAbilities():
	ability1Timer = ability1Cooldown
	ability1CurrentStacks = ability1Stacks
	ability2Timer = ability2Cooldown
	ability2CurrentStacks = ability2Stacks

func AbilityIsUsed():
	if (playerInputs.ability1 && ability1CurrentStacks > 0):
		ability1.StartAttack()
		ability1CurrentStacks -= 1
	if (playerInputs.ability2 && ability2CurrentStacks > 0):
		ability2.StartAttack()
		ability2CurrentStacks -= 2

func AbilityCooldowns(delta):
	Ability1Cooldown(delta)
	Ability2Cooldown(delta)

func Ability1Cooldown(delta):
	if (ability1CurrentStacks < ability1Stacks):
		if (ability1Timer > 0):
			ability1Timer -= delta
			ability1Label.text = str("Charges: ", ability1CurrentStacks, "/", ability1Stacks, "\n", snapped(ability1Timer, 0.1))
			return
		else:
			ability1CurrentStacks += 1
			if (ability1CurrentStacks == ability1Stacks):
				ability1Timer = ability1Cooldown
				ability1Label.text = str("Charges: ", ability1CurrentStacks, "/", ability1Stacks)
			else:
				ability1Timer += ability1Cooldown

func Ability2Cooldown(delta):
	if (ability2CurrentStacks < ability2Stacks):
		if (ability2Timer > 0):
			ability2Timer -= delta
			ability1Label.text = str("Charges: ", ability2CurrentStacks, "/", ability2Stacks, "\n", snapped(ability2Timer, 0.1))
			return
		else:
			ability2CurrentStacks += 1
			if (ability2CurrentStacks == ability2Stacks):
				ability2Timer = ability2Cooldown
				ability1Label.text = str("Charges: ", ability2CurrentStacks, "/", ability2Stacks)
			else:
				ability2Timer += ability2Cooldown
