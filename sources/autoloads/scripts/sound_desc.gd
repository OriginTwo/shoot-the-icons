class_name SoundDesc
extends Resource

enum Kind {
	SHOOT,
	HURT,
	ENEMY_DIED,
	GAME_START,
	GAME_OVER,
}

@export var kind: Kind
@export var stream: AudioStream
@export_range(-40.0, 6.0, 0.01) var volume: float = 0.0
@export_range(0.0, 4.0, 0.01) var pitch_scale: float = 1.0
@export var pitch_randomness: float = 0.0
