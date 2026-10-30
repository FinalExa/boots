class_name AbilitySelectScreen
extends Control

@export var playerHub: PlayerHub
@export var abilityDataButtonRef: String
@export var startingPosition: Vector2
@export var overflowValue: int
@export var buttonDistance: Vector2
var buttons: Array[AbilityButton]

func GenerateDataButtons():
	self.hide()
	buttons.clear()
	for i in playerHub.hubData.abilities.size():
		buttons.push_back(SpawnButton(playerHub.hubData.abilities[i], i))

func SpawnButton(abilityData: AbilityData, index: int):
	var buttonScene = load(abilityDataButtonRef)
	var buttonRef: AbilityButton = buttonScene.instantiate()
	buttonRef.abilitySelectScreen = self
	buttonRef.AddButtonData(abilityData, index)
	self.add_child(buttonRef)
	SetButtonPosition(buttonRef, index)
	if (buttonRef.value == playerHub.hubData.selectedAbilityID):
		buttonRef.SetSelected()
	return buttonRef

func SetButtonPosition(buttonRef: AbilityButton, index: int):
	var valueX: float = buttonRef.size.x + buttonRef.textureRect.size.x + buttonDistance.x
	var valueY: float = buttonRef.size.y + buttonDistance.y
	var overflowMult: Vector2 = CalculateOverflow(index)
	buttonRef.position = startingPosition + Vector2(valueX * overflowMult.x, valueY * overflowMult.y)

func CalculateOverflow(index: int):
	var count: int = 0
	while (index - overflowValue >= 0):
		count += 1
		index -= overflowValue
	return Vector2(count, index)

func ReturnButtonValue(value: int):
	buttons[playerHub.hubData.selectedAbilityID].SetActive()
	buttons[value].SetSelected()
	playerHub.hubData.SetAbilityID(value)

func DonePressed():
	CloseAbilityScreen()

func OpenAbilityScreen():
	self.show()
	get_tree().paused = true

func CloseAbilityScreen():
	self.hide()
	get_tree().paused = false
