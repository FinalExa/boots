extends Area2D

var playerRef: PlayerCharacter
var playerIn: bool

func _process(_delta):
	CheckForPlayerKill()

func _on_body_entered(body):
	if (body is PlayerCharacter):
		if (playerRef == null):
			playerRef = body
		playerIn = true

func _on_body_exited(body):
	if (body is PlayerCharacter):
		playerIn = false

func CheckForPlayerKill():
	if (playerIn && playerRef.playerMovements.currentSpeed < playerRef.playerMovements.killSpeedValue):
		get_tree().reload_current_scene()
