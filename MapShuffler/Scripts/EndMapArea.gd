class_name EndMapArea
extends Area2D

func _on_body_entered(body):
	if (body is PlayerCharacter):
		GoToNextMap()

func GoToNextMap():
	var sceneMaster: SceneMaster = get_tree().root.get_child(0)
	sceneMaster.sceneSelector.call_deferred("ShuffleScene")
