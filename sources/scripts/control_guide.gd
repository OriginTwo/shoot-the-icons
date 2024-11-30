extends CanvasLayer

@onready var animation_player: AnimationPlayer = $Visual/AnimationPlayer

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_left") || Input.is_action_just_pressed("ui_right"):
		animation_player.stop()
		hide()
