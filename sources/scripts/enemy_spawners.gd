extends Node2D

const ENEMY_SCENE := preload("res://sources/enemy.tscn")

@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawners: Array[Marker2D] = [$Spawner1, $Spawner2, $Spawner3, $Spawner4, $Spawner5]

func _ready() -> void:
	spawn_timer.timeout.connect(on_spawn)
	
	var tween := create_tween()
	tween.tween_property(spawn_timer, "wait_time", 2.5, 30.0)
	tween.tween_property(spawn_timer, "wait_time", 2.0, 60.0)
	tween.tween_property(spawn_timer, "wait_time", 1.5, 180.0)
	tween.tween_interval(30.0)
	tween.tween_property(spawn_timer, "wait_time", 1.2, 40.0)
	tween.tween_interval(20.0)
	tween.tween_property(spawn_timer, "wait_time", 1.0, 60.0)
	tween.tween_interval(60.0)
	tween.tween_property(spawn_timer, "wait_time", 0.975, 30.0)

func on_spawn() -> void:
	var enemy := ENEMY_SCENE.instantiate()
	get_tree().current_scene.add_child(enemy)
	enemy.global_position = spawners.pick_random().global_position
