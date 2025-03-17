extends Camera3D

@onready var ray_cast : RayCast3D = $RayCast3D

@export var wheel : Wheel

@export var mouse_sensitivity_x = 0.3 #Mouse sensitivity X axis
@export var mouse_sensitivity_y = 0.3 #Mouse sensitivity Y axis
@export var mouse_max_up = 90 #Mouse max look angle up
@export var mouse_max_down = -80 #Mouse max look angle down
@export var mouse_captured = true

var bomb := preload("res://bomb.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if mouse_captured:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	wheel.new_dir_chosen.connect(new_dir_chosen)
	wheel.puzzle_finished.connect(func(): wheel.reset())
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouse_captured:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		mouse_captured = !mouse_captured

	#Mouse movement
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		self.rotation_degrees.y += -event.relative.x * mouse_sensitivity_x
		self.rotation_degrees.x = clamp(self.rotation_degrees.x + -event.relative.y * mouse_sensitivity_y, mouse_max_down, mouse_max_up)

func new_dir_chosen(wp:Wheel.WheelPayload):
	match wp.base_value:
		1: # Shoot
			if ray_cast.is_colliding():
				var collider = ray_cast.get_collider()
				if collider is Enemy:
					collider.damage(wp.slice_value)
		2: # Bomb
			var new_bomb : Bomb = bomb.instantiate()
			new_bomb.transform.origin = transform.origin
			new_bomb.transform.origin.z -= 1
			# This is hackey as shit but it might work
			new_bomb.linear_velocity = ($MeshInstance3D.global_position - global_position).normalized()
			new_bomb.linear_velocity.y *= -.5
			
			new_bomb.aoe_size = wp.slice_value
			get_parent().add_child(new_bomb)
		3:
			pass
		4:
			pass
	print("-----")
	print("Base Val: ", wp.base_value)
	print("Slice Val: ", wp.slice_value)
	print("Total Val: ", wp.total_value)
	pass
