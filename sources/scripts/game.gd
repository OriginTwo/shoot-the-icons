extends Node2D

func _ready() -> void:
	randomize()
	
	AudioManager.play_sound(SoundDesc.Kind.GAME_START)
	Global.game_over.connect(on_game_over)
	
	Global.score = 0
	Global.hit_point_left = Global.MAX_HIT_POINT

func on_game_over() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://sources/game_over.tscn")
