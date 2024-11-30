extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

var alpha: float = 0.0 :
	set(value):
		alpha = value
		color_rect.material.set_shader_parameter("alpha", alpha)

func _ready() -> void:
	Global.hit_point_reduced.connect(on_damage_received)

func on_damage_received(new_hit_point: int) -> void:
	var tween := create_tween().set_ease(Tween.EASE_IN)
	if new_hit_point == 1:
		tween.tween_property(self, "alpha", 0.5, 0.15)
	else:
		tween.tween_property(self, "alpha", 1.0, 0.15)
		tween.tween_property(self, "alpha", 0.0, 0.15)
