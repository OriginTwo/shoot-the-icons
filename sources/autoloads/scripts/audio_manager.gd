extends Node2D

@export var sound_list: Array[SoundDesc]
@export var music: AudioStreamPlayer

var sound_dict: Dictionary

func _ready() -> void:
	for sound_desc: SoundDesc in sound_list:
		sound_dict[sound_desc.kind] = sound_desc

func play_sound(kind: SoundDesc.Kind) -> void:
	if !sound_dict.has(kind):
		return
	
	var audio := AudioStreamPlayer.new()
	add_child(audio)
	audio.finished.connect(audio.queue_free)
	
	var sound_desc: SoundDesc = sound_dict[kind]
	audio.stream = sound_desc.stream
	audio.volume_db = sound_desc.volume
	audio.pitch_scale = sound_desc.pitch_scale
	audio.pitch_scale += randf_range(-sound_desc.pitch_randomness, sound_desc.pitch_randomness)
	
	audio.play()

func play_music() -> void:
	if !music.playing:
		music.play()
