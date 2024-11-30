extends Node2D

@onready var title_label: Label = %TitleLabel
@onready var high_score_label: Label = %HighScoreLabel
@onready var change_title_color_timer: Timer = $ChangeTitleColorTimer

const TITLE_COLORS: Array[Color] = [Color8(200, 140, 60), Color8(255, 60, 60)]
var title_color_index: int = 0

func _ready() -> void:
	Global.load_data()
	
	high_score_label.text = "High Score: %d" % Global.high_score
	
	change_title_color_timer.timeout.connect(on_change_title_color)
	
	AudioManager.play_music()

func _unhandled_input(event: InputEvent) -> void:
	if !event is InputEventKey:
		return
	
	if event.pressed:
		match event.keycode:
			KEY_SPACE:
				get_tree().change_scene_to_file("res://sources/game.tscn")
			KEY_ESCAPE:
				get_tree().quit()

func on_change_title_color() -> void:
	title_color_index = (title_color_index + 1) % len(TITLE_COLORS)
	title_label.add_theme_color_override("font_shadow_color", TITLE_COLORS[title_color_index])
