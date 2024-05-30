class_name EnemyShielded
extends Node

@export var shieldSprite: Sprite2D
var shieldedBy: EnemyShielding

func _ready():
	shieldSprite.hide()

func SetShielded(shielder: EnemyShielding):
	shieldSprite.show()
	shieldedBy = shielder

func RemoveShielded():
	shieldedBy.RemoveShield()
