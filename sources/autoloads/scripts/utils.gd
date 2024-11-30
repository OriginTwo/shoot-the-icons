extends Node

const CAMERA_SHAKE_DECAY := 4.0
const CAMERA_SHAKE_OFFSET := 4.0

var camera_shake_strength: float = 0.0

func _process(delta: float) -> void:
	if camera_shake_strength >= 0.0 && get_tree().current_scene is Node2D:
		get_tree().current_scene.position = CAMERA_SHAKE_OFFSET * Vector2(
			randf_range(-camera_shake_strength, camera_shake_strength),
			randf_range(-camera_shake_strength, camera_shake_strength))
	
	camera_shake_strength = max(camera_shake_strength - CAMERA_SHAKE_DECAY * delta, 0.0)

func shake_camera(strength: float = 1.0) -> void:
	camera_shake_strength = clamp(camera_shake_strength + strength, 0.0, 1.0)
