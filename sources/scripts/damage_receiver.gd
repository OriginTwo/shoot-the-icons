extends Area2D

func _ready() -> void:
	area_entered.connect(on_damage_received)

func on_damage_received(area: Area2D) -> void:
	if area is Enemy:
		area.deal_damage()
		Utils.shake_camera()
