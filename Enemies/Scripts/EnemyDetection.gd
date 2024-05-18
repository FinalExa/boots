extends Area2D

@export var enemyMovement: EnemyMovement
var playerFound: bool
var playerRef: PlayerCharacter

@export var normalSprite: Sprite2D
@export var angrySprite: Sprite2D

func _ready():
	angrySprite.hide()

func _process(_delta):
	ChasePlayer()

func _on_body_entered(body):
	SetChasePlayer(body)

func SetChasePlayer(body):
	if (!playerFound && body is PlayerCharacter):
		playerRef = body
		playerFound = true
		normalSprite.hide()
		angrySprite.show()

func ChasePlayer():
	if (playerFound):
		enemyMovement.ResetMovementSpeed()
		enemyMovement.SetNewTarget(playerRef)
