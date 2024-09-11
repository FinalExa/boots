class_name MapData
extends Node

@export var mapName: String
@export var mapDifficultyLevels: Array[MapDifficultyLevel]
@export var mapFloors: Array[FloorTypes]
@export var mapMinDifficulty: Array[float]
@export var mapMaxDifficulty: Array[float]

enum FloorTypes
{
	START,
	NORMAL,
	SHOP,
	BOSS
}

func CompleteMap():
	pass
