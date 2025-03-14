extends Node2D

func _ready() -> void:
	$Wheel.puzzle_finished.connect(restart)

func restart():
	$Wheel.reset()
