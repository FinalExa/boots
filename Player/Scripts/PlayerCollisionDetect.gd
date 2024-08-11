class_name PlayerCollisionDetect
extends Area2D

signal hit

@export var collisionICD: float
var collisionTimer: float
var currentCollisions: Array[Node2D]

func _ready():
	collisionTimer = 0

func _process(delta):
	CollisionICD(delta)

func CollisionICD(delta):
	if (collisionTimer > 0):
		collisionTimer -= delta

func _on_body_entered(body):
	if (!((body is PlayerCharacter) || (body is EnemyController))  && !currentCollisions.has(body)):
		if (currentCollisions.size() == 0 && collisionTimer <= 0):
			print("hit")
			emit_signal("hit")
		currentCollisions.push_back(body)

func _on_body_exited(body):
	if (currentCollisions.has(body)):
		currentCollisions.erase(body)
		if (currentCollisions.size() == 0):
			collisionTimer = collisionICD
