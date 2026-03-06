class_name MapObjective
extends Node

@export var objectiveDescription: String
@export var objectiveNotCompletedDescription: String
@export var objectiveCompletedDescription: String
@export var gameplayScene: GameplayScene
var playerRef: PlayerCharacter

func _ready():
	StartRefs()
	ReadyOperations()

func ReadyOperations():
	pass

func StartRefs():
	playerRef = get_tree().root.get_child(0).sceneSelector.playerRef
	gameplayScene.objective = self

func RequestEnemyData(_enemyController: EnemyController):
	pass

func ObjectiveCompleted():
	gameplayScene.SetObjectiveCompleted()

func OnSpawnedEnemyDeath():
	pass
