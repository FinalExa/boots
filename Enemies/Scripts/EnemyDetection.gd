class_name EnemyDetection
extends Area2D

var playerFound: bool
var playerRef: PlayerCharacter

@export var normalSprite: Sprite2D
@export var angrySprite: Sprite2D

func _ready():
	angrySprite.hide()

func _on_body_entered(body):
	SetChasePlayer(body)

func SetChasePlayer(body):
	if (!playerFound && body is PlayerCharacter):
		playerRef = body
		playerFound = true
		normalSprite.hide()
		angrySprite.show()
