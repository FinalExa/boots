class_name PlayerCharacter
extends CharacterBody2D

@export var playerMovements: PlayerMovements
@export var currentObjectiveUI: CurrentObjectiveUI
@export var playerSpeedThresholds: PlayerSpeedThresholds
@export var playerInputs: PlayerInputs
@export var powerUpUI: PowerUpUI
@export var shopUI: ShopUI
@export var powerUpManager: PowerUpManager
@export var playerHealth: PlayerHealth
@export var moneyLabel: Label
@export var currentRoomLabel: Label
@export var rewardSpawn: RewardSpawn
var collisionResult: bool
@export var currentMoney: float

func _ready():
	UpdateMoney(0)

func _physics_process(_delta):
	collisionResult = move_and_slide()

func UpdateMoney(valueToAdd):
	currentMoney += valueToAdd
	moneyLabel.text = str("ECTOCRYSTALS: ", currentMoney)

func UpdateCurrentRoomCount(currentRoomValue: String):
	currentRoomLabel.text = str("Current Room: ", currentRoomValue)
