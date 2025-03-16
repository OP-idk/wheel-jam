extends Camera3D

@export var wheel : Wheel

@export var mouse_sensitivity_x = 0.3 #Mouse sensitivity X axis
@export var mouse_sensitivity_y = 0.3 #Mouse sensitivity Y axis
@export var mouse_max_up = 90 #Mouse max look angle up
@export var mouse_max_down = -80 #Mouse max look angle down
@export var mouse_captured = true
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
	print("-----")
	print("Base Val: ", wp.base_value)
	print("Slice Val: ", wp.slice_value)
	print("Total Val: ", wp.total_value)
	pass
