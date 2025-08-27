extends Node2D
class_name EnemyAttackComponent

@onready var lifetime_timer: Timer = $LifetimeTimer
@onready var cool_down_timer: Timer = $CooldownTimer
@onready var world: Node2D = get_tree().current_scene.get_child(0)

var attack_area_instances: Array[Node]
var direction: Vector2 = Vector2.ZERO
var is_cooldown: bool = false


const BOW: WeaponProperties = preload("res://Weapons/bow.tres")
const SWORD: WeaponProperties = preload("res://Weapons/sword.tres")

var available_weapons: Array = [
	BOW,
]


@export var active_weapon_data: WeaponProperties = available_weapons[0]

enum AttackTypes{
	MELEE,
	RANGED
}



func _process(delta: float) -> void:
	direction = (world.player.global_position - global_position).normalized()
	attack()


func attack():
	if is_cooldown: return
	# Handle attack area transform
	set_rotation(_coords_to_angle(direction))
	# Handle Timers
	lifetime_timer.wait_time = active_weapon_data.lifetime
	cool_down_timer.wait_time = active_weapon_data.cooldown
	lifetime_timer.start()
	cool_down_timer.start()
	is_cooldown = true
	# Spawn attack area
	var attack_area = active_weapon_data.attack_area.instantiate()
	attack_area_instances.append(attack_area)
		
	# Set attack area properties
	if active_weapon_data.attack_type == AttackTypes.RANGED:
		attack_area.enemy_group = "player"
		attack_area.global_transform = global_transform
		world.EntityPool.call_deferred("add_child", attack_area)
	else:
		call_deferred("add_child", attack_area)
	#attack_area.get_node("Polygon2D").set_polygon(attack_area.get_node("AttackPolygon").get_polygon())
	attack_area.body_entered.connect(on_body_attacked)


func _on_lifetime_timeout() -> void:
	if attack_area_instances and active_weapon_data.attack_type == AttackTypes.RANGED:
		if attack_area_instances.front():
			attack_area_instances.pop_front().queue_free()


func _on_cooldown_timeout() -> void:
	is_cooldown = false
	cool_down_timer.stop()


func on_body_attacked(body: Node):
	#if body.is_in_group("damagable"): 
		#body.recieve_damage(active_weapon_data.damage)
		#return
	if body is Player: 
		body.recieve_damage(active_weapon_data.damage)
		return


func _coords_to_angle(coords: Vector2) -> float:
	var angle: float = 0
	var x: float = coords.x; var y: float = coords.y
	if x >= 0: angle = asin(y)
	if x < 0:
		if y >= 0: angle = acos(x)
		else: angle = -acos(x)
	return angle
