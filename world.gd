extends Node3D

@export var player : Player

func _process(delta : float) -> void:
	get_tree().call_group("enemy", "set_target_position", $Player.global_transform.origin)


	
 
