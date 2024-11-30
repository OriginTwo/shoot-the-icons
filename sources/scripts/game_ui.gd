extends CanvasLayer

@onready var score_label: Label = %ScoreLabel
@onready var hit_point_display: HBoxContainer = %HitPointDisplay

func _ready() -> void:
	Global.score_changed.connect(on_score_changed)
	Global.hit_point_reduced.connect(on_hit_point_changed)
	
	var hit_point_elem := hit_point_display.get_child(0)
	for i in Global.MAX_HIT_POINT - 1:
		hit_point_display.add_child(hit_point_elem.duplicate())
	
	score_label.pivot_offset = score_label.size/2.0
	hit_point_display.pivot_offset = hit_point_display.size/2.0

func on_score_changed(new_score: int) -> void:
	var tween := create_tween()
	tween.tween_property(score_label, "scale", Vector2.ONE, 0.2).from(Vector2.ONE*1.6)
	score_label.text = "%d" % new_score

func on_hit_point_changed(_new_hit_point: int) -> void:
	var tween := create_tween()
	tween.tween_property(hit_point_display, "scale", Vector2.ONE, 0.2).from(Vector2.ONE*1.2)
	
	var child_count := hit_point_display.get_child_count()
	var child := hit_point_display.get_child(child_count - 1)
	hit_point_display.remove_child(child)
	child.queue_free()
