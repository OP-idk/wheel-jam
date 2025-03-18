class_name Explosion
extends Sprite3D

var player_position : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("explode")
	player_position = get_parent().player.transform.origin
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(player_position)
	pass


func _on_audio_stream_player_3d_finished() -> void:
	queue_free()
	pass # Replace with function body.
