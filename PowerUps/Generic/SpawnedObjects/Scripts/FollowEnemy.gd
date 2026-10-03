class_name FollowEnemy
extends Area2D

var objectToMove: Node2D
var enemiesInRange: Array[EnemyController]
var chosenEnemy: EnemyController
@export var decisionTime: float
@export var moveSpeed: float
var timer: float

func _ready():
	objectToMove = get_parent()
	timer = decisionTime

func _process(delta):
	Decision(delta)
	Chase()

func Decision(delta):
	if (timer > 0):
		timer -= delta
		return
	if (chosenEnemy == null):
		SetChosenEnemy()

func SetChosenEnemy():
	var distance: float
	for i in enemiesInRange.size():
		var currentDistance: float = objectToMove.global_position.distance_to(enemiesInRange[i].global_position)
		if (i == 0):
			distance = currentDistance
			chosenEnemy = enemiesInRange[i]
		else:
			if (currentDistance < distance):
				distance = currentDistance
				chosenEnemy = enemiesInRange[i]

func Chase():
	if (chosenEnemy != null):
		objectToMove.global_position += objectToMove.global_position.direction_to(chosenEnemy.global_position * moveSpeed)

func _on_body_entered(body):
	if (body is EnemyController && !enemiesInRange.has(body)):
		enemiesInRange.push_back(body)

func _on_body_exited(body):
	if (body is EnemyController && enemiesInRange.has(body)):
		enemiesInRange.erase(body)
