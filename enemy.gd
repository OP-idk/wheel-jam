class_name Enemy
extends CharacterBody3D

@export var speed = 3.0
@export var accel_weight = 0.25
@export var nav : NavigationAgent3D

var health : int = 4
var alive = true

func _ready():
	%ProgressBar.value = health
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * speed
	
	if alive: velocity = velocity.move_toward(new_velocity, accel_weight)
	else: velocity = velocity.move_toward(Vector3.ZERO, accel_weight / 100)
	move_and_slide()

func set_target_position(target : Vector3) -> void:
	nav.target_position = target

func damage(dmg : int) -> void:
	health -= dmg
	%ProgressBar.value = health
	if health <= 0:
		die()

func die():
	alive = false
	$MeshInstance3D.mesh.material.albedo_color = "#e700bc"
	await get_tree().create_timer(.25).timeout
	queue_free()
