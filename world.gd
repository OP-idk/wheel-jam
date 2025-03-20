extends Node3D

@export var player : Player

var enemy := preload("res://enemy.tscn")

func _process(delta : float) -> void:
	get_tree().call_group("enemy", "set_target_position", $Player.global_transform.origin)


	
 


func _on_enemy_spawn_timer_timeout() -> void:
	# 16, +- 15
	var new_enemy : Enemy = enemy.instantiate()
	randomize()
	new_enemy.position = Vector3(randf_range(-15, 15), 1.5, -16.0)
	new_enemy.add_to_group("enemy")
	
	add_child(new_enemy)
	pass # Replace with function body.
