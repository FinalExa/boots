class_name EnemyDetection
extends Area2D

var playerFound: bool
var playerRef: PlayerCharacter

@export var enemyController: EnemyController
@export var normalSprite: Sprite2D
@export var angrySprite: Sprite2D
@export var stopSwapSprite: bool

func _ready():
	angrySprite.hide()

func _on_body_entered(body):
	SetChasePlayer(body)

func SetChasePlayer(body):
	if (!playerFound && body is PlayerCharacter):
		playerRef = body
		enemyController.playerRef = playerRef
		playerFound = true
		if (!stopSwapSprite):
			normalSprite.hide()
			angrySprite.show()
