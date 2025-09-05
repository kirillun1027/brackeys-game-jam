class_name Weapon

var damage: int
var attack_type: WeaponProperties.AttackTypes
var lifetime: float
var cooldown: float
var attack_area: PackedScene
var cost: int
var icon: Texture
var instance_of: StringName

func _init(weapon_data: WeaponProperties) -> void:
	damage = weapon_data.damage
	attack_type = weapon_data.attack_type
	lifetime = weapon_data.lifetime
	cooldown = weapon_data.cooldown
	attack_area = weapon_data.attack_area
	cost = weapon_data.cost
	instance_of = weapon_data.name
	icon = weapon_data.icon
