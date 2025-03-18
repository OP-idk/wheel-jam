class_name Bomb
extends RigidBody3D

@onready var explosion_shape : CollisionShape3D = $ExplosionArea/CollisionShape3D

var enemyList : Array[Enemy] = []
var launch_strength = 15
var aoe_size = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	linear_velocity *= launch_strength
	explosion_shape.shape.radius = aoe_size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_explosion_area_body_entered(body: Node3D) -> void:
	if body is Enemy:
		enemyList.append(body)
	pass # Replace with function body.


func _on_explosion_area_body_exited(body: Node3D) -> void:
	for i in range(enemyList.size() - 1, 0, -1):
		if enemyList[i] == body:
			enemyList.remove_at(i)
	pass # Replace with function body.

func _on_trigger_area_body_entered(body: Node3D) -> void:
	for enemy in enemyList:
		enemy.damage(1)
	queue_free()
	pass # Replace with function body.
