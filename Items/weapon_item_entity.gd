extends Area2D

@export var weapon_data: WeaponProperties



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.attack_component.available_weapons.append(weapon_data)
		queue_free()
