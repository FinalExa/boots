class_name PlayerHealth
extends Node

@export var heartRef: String
@export var heartStartPosition: Control
@export var maxHearts: int
@export var maxHealth: float
@export var playerMovements: PlayerMovements
@export var invulnerabilityTime: float
var invulnerabilityTimer: float
var invulnerabilityActive: bool
var currentHearts: int
var playerHearts: Array[PlayerHeart]
var currentHealth: float

func _ready():
	call_deferred("GenerateHearts")

func _process(delta):
	if (invulnerabilityActive):
		InvulnerabilityTimer(delta)

func UpdateHealthValue(valueToAdd: float):
	currentHealth = clamp(currentHealth + valueToAdd, 0, maxHealth)
	UpdateBar()
	if (currentHealth <= 0):
		LoseHeart()

func UpdateBar():
	playerHearts[currentHearts].UpdateHealth(currentHealth)

func CheckForDamageType(damage: float):
	if (playerMovements.currentSpeed > playerMovements.killSpeedValue):
		UpdateHealthValue(-damage)
		StartInvulnerability()
		return
	LoseHeart()
	StartInvulnerability()

func GenerateHearts():
	for i in (maxHearts):
		var heart: PlayerHeart = load(heartRef).instantiate()
		heartStartPosition.add_child(heart)
		heart.global_position = heartStartPosition.global_position + Vector2(heart.size.x * i, 0)
		heart.Startup(maxHealth, 0)
		playerHearts.push_back(heart)
	currentHearts = maxHearts - 1
	currentHealth = maxHealth

func LoseHeart():
	playerHearts[currentHearts].SetEmpty()
	currentHearts -= 1
	if (currentHearts >= 0):
		currentHealth = maxHealth
		return
	GameOver()

func InvulnerabilityTimer(delta):
	if (invulnerabilityTimer > 0):
		invulnerabilityTimer -= delta
		return
	invulnerabilityActive = false

func StartInvulnerability():
	invulnerabilityTimer = invulnerabilityTime
	invulnerabilityActive = true

func GameOver():
	get_tree().root.get_child(0).LoadHub()
