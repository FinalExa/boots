extends Area2D

@export var distMultiplier: float
var entitiesInArea: Array[Node2D]

func _physics_process(_delta):
	UnstuckEntities()

func _on_body_entered(body):
	if (body is EnemyController && !entitiesInArea.has(body)):
		entitiesInArea.push_back(body)

func _on_body_exited(body):
	if (entitiesInArea.has(body)):
		entitiesInArea.erase(body)

func UnstuckEntities():
	if (entitiesInArea.size()>0):
		for i in entitiesInArea.size():
			entitiesInArea[i].global_position += distMultiplier * (self.global_position.direction_to(entitiesInArea[i].global_position))
