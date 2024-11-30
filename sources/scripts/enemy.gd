class_name Enemy
extends Area2D

const SMOKE_PARTICLE_SCENE := preload("res://sources/smoke_particle.tscn")

const ICON_COUNT := 78
const SPEED := 50.0

@onready var icon: Sprite2D = $Icon

func _ready() -> void:
	icon.frame = randi_range(0, ICON_COUNT - 1)

func _process(delta: float) -> void:
	global_position += Vector2.DOWN*SPEED*delta

func take_damage() -> void:
	Global.score += 1
	AudioManager.play_sound(SoundDesc.Kind.ENEMY_DIED)
	die()

func deal_damage() -> void:
	Global.hit_point_left -= 1
	AudioManager.play_sound(SoundDesc.Kind.HURT)
	die()

func die() -> void:
	var smoke := SMOKE_PARTICLE_SCENE.instantiate()
	get_tree().current_scene.add_child(smoke)
	smoke.global_position = global_position
	queue_free()
