extends Node2D
class_name AttackComponent

@onready var lifetime_timer: Timer = $LifetimeTimer
@onready var cool_down_timer: Timer = $CooldownTimer

var attack_area_instances: Array[Node]
var direction: Vector2 = Vector2.ZERO
var is_cooldown: bool = false


const BOW: WeaponProperties = preload("res://Weapons/bow.tres")
const SWORD: WeaponProperties = preload("res://Weapons/sword.tres")

var player_id: int = 1

@export var active_weapon_data: WeaponProperties = BOW

enum AttackTypes{
	MELEE,
	RANGED
}


 
func _on_body_attacked(body: Node2D) -> void:
	if body is Player and body.player_id == player_id:
		return
	if body is Player:
		body.die()
		print(body.player_id)
		return
	body.queue_free()
	print("attack log")

func attack():
	if is_cooldown: return
	set_rotation(_coords_to_angle(direction))
	lifetime_timer.wait_time = active_weapon_data.lifetime
	cool_down_timer.wait_time = active_weapon_data.cooldown
	lifetime_timer.start()
	cool_down_timer.start()
	is_cooldown = true
	var attack_area = active_weapon_data.attack_area.instantiate()
	attack_area.global_transform = global_transform
	attack_area_instances.append(attack_area)
	#attack_area.get_node("Polygon2D").set_polygon(attack_area.get_node("AttackPolygon").get_polygon())
	get_parent().EntityPool.call_deferred("add_child", attack_area)
	attack_area.body_entered.connect(on_body_attacked)


func _on_lifetime_timeout() -> void:
	if attack_area_instances:
		attack_area_instances.pop_front().queue_free()

func _on_cooldown_timeout() -> void:
	is_cooldown = false


func on_body_attacked(body: Node):
	if body.is_in_group("damagable"): body.recieve_damage(active_weapon_data.damage); return
	if body is Player and body.name != get_parent().name: 
		body.recieve_damage(active_weapon_data.damage)
		return


func _on_update_direction(dir: Vector2) -> void:
	if dir == Vector2.ZERO: return
	direction = dir
	

func _coords_to_angle(coords: Vector2) -> float:
	var angle: float = 0
	var x: float = coords.x; var y: float = coords.y
	if x >= 0: angle = asin(y)
	if x < 0:
		if y >= 0: angle = acos(x)
		else: angle = -acos(x)
	return angle
