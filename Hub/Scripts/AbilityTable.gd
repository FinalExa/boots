class_name AbilityTable
extends StaticBody2D

@export var hubData: HubData
@export var inputIcon: AnimatedSprite2D
var playerHubRef: PlayerHub

func _ready():
	inputIcon.hide()

func _process(_delta):
	ListenForPlayerInput()

func ListenForPlayerInput():
	if (playerHubRef != null):
		if (playerHubRef.playerInputs.interactionInput):
			OpenSelectionScreen()

func OpenSelectionScreen():
	playerHubRef.abilitySelectScreen.OpenAbilityScreen()

func PlayerIn(body):
	if (body is PlayerHub):
		inputIcon.show()
		playerHubRef = body

func PlayerOut(body):
	if (body is PlayerHub):
		inputIcon.hide()
		playerHubRef = null
