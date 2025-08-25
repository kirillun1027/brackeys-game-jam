extends Node
class_name WeaponData

enum AttackTypes{
	MELEE,
	RANGED,
}

class Weapon:
	var damage: int
	var attack_type: AttackTypes
	var lifetime: float
	var cooldown: float
	var attack_area: PackedScene

class Bow extends Weapon:
	func _init() -> void:
		damage = 5
		attack_type
