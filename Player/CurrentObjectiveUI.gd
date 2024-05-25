class_name CurrentObjectiveUI
extends Label

func UpdateText(title: String, objectiveData: String):
	text = str(title, "\n", objectiveData)
