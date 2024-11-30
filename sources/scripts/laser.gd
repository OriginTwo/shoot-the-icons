extends Area2D

const SPEED: float = 150.0

@onready var lifetime_timer: Timer = $LifetimeTimer

func _ready() -> void:
	area_entered.connect(on_hit)
	lifetime_timer.timeout.connect(queue_free)

func _process(delta: float) -> void:
	global_position += Vector2.UP*SPEED*delta

func on_hit(area: Area2D) -> void:
	if area is Enemy:
		area.take_damage()
		queue_free()
