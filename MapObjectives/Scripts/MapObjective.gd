class_name MapObjective
extends Node

@export var gameplayScene: GameplayScene

func RequestEnemyData(enemyController: EnemyController):
	pass

func ObjectiveCompleted():
	gameplayScene.SetCompleted()
