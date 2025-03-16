extends Node3D


func _process(delta : float) -> void:
	get_tree().call_group("enemy", "set_target_position", $Player.global_transform.origin)


	
 
