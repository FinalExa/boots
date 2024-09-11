class_name MapDifficultyLevel
extends Node

@export var associatedLevels: Array[String]
@export var bannedLevels: Array[String]

func SelectLevel(levelSelected: String):
	if (associatedLevels.has(levelSelected)):
		associatedLevels.erase(levelSelected)
		if (!bannedLevels.has(levelSelected)):
			bannedLevels.push_back(levelSelected)

func ResetSelectedLevels():
	for i in bannedLevels.size():
		associatedLevels.push_back(bannedLevels[i])
	bannedLevels.clear()
