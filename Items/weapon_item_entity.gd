extends Area2D

@export var weapon_data: WeaponProperties
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite_2d.texture = weapon_data.icon

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.attack_component.add_weapon(weapon_data)
		queue_free()
