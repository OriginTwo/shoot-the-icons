extends Node2D

@onready var high_score_label: Label = %HighScoreLabel
@onready var score_label: Label = %ScoreLabel

func _ready() -> void:
	AudioManager.play_sound(SoundDesc.Kind.GAME_OVER)
	
	Global.high_score = max(Global.high_score, Global.score)
	high_score_label.text = "High Score: %d" % Global.high_score
	score_label.text = "Score: %d" % Global.score
	
	Global.save_data()

func _unhandled_input(event: InputEvent) -> void:
	if !event is InputEventKey:
		return
	
	if event.pressed:
		match event.keycode:
			KEY_SPACE:
				get_tree().change_scene_to_file("res://sources/game.tscn")
			KEY_ESCAPE:
				get_tree().change_scene_to_file("res://sources/main_menu.tscn")
