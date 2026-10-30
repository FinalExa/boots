class_name AbilityButton
extends Button

@export var textureRect: TextureRect
@export var secondRowText: String
@export var thirdRowText: String
@export var selectedText: String
var abilityData: AbilityData
var abilitySelectScreen: AbilitySelectScreen
var value: int

func AddButtonData(abilityRef: AbilityData, index: int):
	abilityData = abilityRef
	textureRect.texture = abilityData.textureRef
	ComposeBaseText()
	value = index

func ComposeBaseText():
	self.text = str(abilityData.abilityName, "\n", secondRowText, abilityData.cooldown, "\n", thirdRowText, abilityData.stacks)

func ComposeSelectedText():
	ComposeBaseText()
	self.text = str(self.text, "\n", selectedText)

func AbilitySelected():
	abilitySelectScreen.ReturnButtonValue(value)

func SetActive():
	disabled = false
	ComposeBaseText()

func SetSelected():
	disabled = true
	ComposeSelectedText()
