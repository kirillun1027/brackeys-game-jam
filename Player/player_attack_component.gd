extends Node2D
class_name PlayerAttackComponent

@onready var lifetime_timer: Timer = $LifetimeTimer
@onready var cool_down_timer: Timer = $CooldownTimer
@onready var world: Node2D = get_tree().current_scene.get_child(0)

var attack_area_instances: Array[Node]
var direction: Vector2 = Vector2.ZERO
var is_cooldown: bool = false


const BOW: WeaponProperties = preload("res://Weapons/WeaponData/bow.tres")
const SWORD: WeaponProperties = preload("res://Weapons/WeaponData/sword.tres")
const HAMMER: WeaponProperties = preload("res://Weapons/WeaponData/hammer.tres")

var available_weapons: Array[Weapon] = [
	
]

var active_weapon: Weapon

var AttackTypes = WeaponProperties.AttackTypes

var WeaponBaseStats: Dictionary[Weapon, WeaponProperties] = {
	
}

func _ready() -> void:
	add_weapon(HAMMER)

func add_weapon(properties: WeaponProperties):
	var new_weapon = Weapon.new(properties)
	available_weapons.append(new_weapon)
	WeaponBaseStats.set(new_weapon, properties)

func _process(delta: float) -> void:
	direction = (get_global_mouse_position() - global_position).normalized()


#region Weapon Swap and Input

func swap_weapons():
	var current_weapon_id = available_weapons.find(active_weapon)
	if current_weapon_id < available_weapons.size() - 1:
		active_weapon = available_weapons[current_weapon_id + 1]
	else:
		active_weapon = available_weapons[0]

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("weapon_swap"):
		if !available_weapons.is_empty(): swap_weapons()
#endregion


#region Attack Management

func attack():
	if !active_weapon: return
	if is_cooldown: return
	set_rotation(_coords_to_angle(direction)) # Handle attack area transform
	
	# Handle Timers
	lifetime_timer.wait_time = active_weapon.lifetime
	cool_down_timer.wait_time = active_weapon.cooldown
	lifetime_timer.start()
	cool_down_timer.start()
	is_cooldown = true
	
	var attack_area = active_weapon.attack_area.instantiate() # Spawn attack area
	attack_area_instances.append(attack_area) # Register attack area
	
	# Set attack area properties
	if active_weapon.attack_type == AttackTypes.RANGED:
		attack_area.global_transform = global_transform
		world.EntityPool.call_deferred("add_child", attack_area)
	else:
		call_deferred("add_child", attack_area)
	
	attack_area.body_entered.connect(on_body_attacked)


func on_body_attacked(body: Node):
	if body.is_in_group("damagable"): 
		body.recieve_damage(active_weapon.damage)
		return
	if body is Player and body.name != get_parent().name: 
		body.recieve_damage(active_weapon.damage)
		return
#endregion


#region Timers

func _on_lifetime_timeout() -> void:
	if attack_area_instances and active_weapon.attack_type == AttackTypes.RANGED:
		if attack_area_instances.front():
			attack_area_instances.pop_front().queue_free()

func _on_cooldown_timeout() -> void:
	is_cooldown = false
	cool_down_timer.stop()

#endregion


func _coords_to_angle(coords: Vector2) -> float:
	var angle: float = 0
	var x: float = coords.x; var y: float = coords.y
	if x >= 0: angle = asin(y)
	if x < 0:
		if y >= 0: angle = acos(x)
		else: angle = -acos(x)
	return angle
