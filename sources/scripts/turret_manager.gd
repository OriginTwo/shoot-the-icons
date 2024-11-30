extends Node2D

@onready var lane_highlight: ColorRect = $LaneHighlight

var shooters: Array[Turret]

var active_index: int :
	set(value):
		shooters[active_index].deactivate()
		active_index = clamp(value, 0, len(shooters) - 1)
		shooters[active_index].activate()
		lane_highlight.position.x = float(active_index*36)

func _ready() -> void:
	for child in get_children():
		if child is Turret:
			shooters.append(child)
	
	@warning_ignore("integer_division")
	active_index = len(shooters)/2

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_left"):
		active_index -= 1
	if Input.is_action_just_pressed("ui_right"):
		active_index += 1
