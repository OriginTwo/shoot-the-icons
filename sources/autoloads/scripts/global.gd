extends Node

const MAX_HIT_POINT := 5

signal game_over
signal score_changed(new_score: int)
signal hit_point_reduced(new_hit_point: int)

var high_score: int = 0

var score: int = 0 :
	set(value):
		score = value
		score_changed.emit(score)

var hit_point_left: int = MAX_HIT_POINT :
	set(value):
		if value < hit_point_left:
			hit_point_reduced.emit(value)
		hit_point_left = clamp(value, 0, MAX_HIT_POINT)
		if hit_point_left <= 0:
			game_over.emit()

func save_data() -> void:
	var save_file := FileAccess.open_encrypted_with_pass("user://data.save", FileAccess.WRITE, "asdfqwerty")
	save_file.store_line(JSON.stringify({
		"high_score": high_score,
	}))

func load_data() -> void:
	if !FileAccess.file_exists("user://data.save"):
		return
	
	var save_file := FileAccess.open_encrypted_with_pass("user://data.save", FileAccess.READ, "asdfqwerty")
	var json_string := save_file.get_line()
	var json := JSON.new()
	json.parse(json_string)
	high_score = json.data["high_score"]
