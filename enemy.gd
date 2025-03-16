class_name Enemy
extends CharacterBody3D


@export var speed = 5.0
@export var accel_weight = 0.25
@export var nav : NavigationAgent3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * speed
	
	velocity = velocity.move_toward(new_velocity, accel_weight)
	move_and_slide()

func set_target_position(target : Vector3) -> void:
	nav.target_position = target

func damage(dmg : int) -> void:
	pass
