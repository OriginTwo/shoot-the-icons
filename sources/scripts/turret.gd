class_name Turret
extends Node2D

const LASER_SCENE := preload("res://sources/laser.tscn")

@onready var cooldown_bar: Sprite2D = $CooldownBar
@onready var muzzle: Marker2D = $Muzzle
@onready var smoke_particle: GPUParticles2D = $SmokeParticle
@onready var flash_particle: GPUParticles2D = $FlashParticle
@onready var cooldown_timer: Timer = $CooldownTimer

func activate() -> void:
	cooldown_timer.paused = false
	modulate = Color.WHITE

func deactivate() -> void:
	cooldown_timer.paused = true
	modulate = Color(0.6, 0.6, 0.6, 1.0)

func _ready() -> void:
	cooldown_timer.timeout.connect(on_shoot)
	cooldown_timer.start()
	deactivate()

func _process(_delta: float) -> void:
	cooldown_bar.scale.x = 1.0 - clamp(cooldown_timer.time_left/cooldown_timer.wait_time, 0.0, 1.0)

func on_shoot() -> void:
	var laser := LASER_SCENE.instantiate()
	get_tree().current_scene.add_child(laser)
	laser.global_position = muzzle.global_position
	smoke_particle.emitting = true
	flash_particle.emitting = true
	AudioManager.play_sound(SoundDesc.Kind.SHOOT)
