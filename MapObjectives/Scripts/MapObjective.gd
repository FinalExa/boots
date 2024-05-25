class_name MapObjective
extends Node

@export var gameplayScene: GameplayScene
var playerRef: PlayerCharacter

func _ready():
	GetPlayer()
	ReadyOperations()

func ReadyOperations():
	pass

func GetPlayer():
	playerRef = get_tree().root.get_child(0).sceneSelector.playerRef

func RequestEnemyData(enemyController: EnemyController):
	pass

func ObjectiveCompleted():
	gameplayScene.SetCompleted()
