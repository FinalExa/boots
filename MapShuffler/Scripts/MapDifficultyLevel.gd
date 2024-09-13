class_name MapDifficultyLevel
extends Node

@export var associatedLevels: Array[String]
@export var bannedLevels: Array[String]

func SelectLevel():
	var levelSelected: String = associatedLevels.pick_random()
	if (associatedLevels.has(levelSelected)):
		associatedLevels.erase(levelSelected)
		if (!bannedLevels.has(levelSelected)):
			bannedLevels.push_back(levelSelected)
	return levelSelected

func ResetSelectedLevels():
	for i in bannedLevels.size():
		associatedLevels.push_back(bannedLevels[i])
	bannedLevels.clear()
