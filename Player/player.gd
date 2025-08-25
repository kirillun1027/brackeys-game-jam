extends CharacterBody2D 
class_name Player

@export var dash_graph: Curve
@export var health: int = 1
@onready var hp: int = health
@export var attack_area_rotation: float = 0
@export var EntityPool: Node
var spawn_points: Node2D
var speed: float = 200
var sprint_speed: float = speed * 2
var dash_speed: float = speed * 5
var is_dashing: bool = false
var dash_direction: Vector2
var player_id: int = 1
signal update_direction(dir: Vector2)
@onready var dash_timer = $DashTimer
@onready var attack_component: AttackComponent = $AttackComponent
@onready var start_position: Vector2 = global_position


func move(_delta: float):
	var direction: Vector2
	if not is_dashing:
		direction = Input.get_vector(
			"walk_left", "walk_right", "walk_up", "walk_down"
		)
	else:
		direction = dash_direction
	
	update_direction.emit(direction)
	
	if Input.is_action_pressed("sprint"):	velocity = sprint_speed * direction
	else: velocity = speed * direction
	
	if Input.is_action_just_pressed("dash"):
		dash_timer.start()
		is_dashing = true
		dash_direction = direction
	
	if is_dashing:
		var progress: float = (dash_timer.wait_time - dash_timer.time_left)/ dash_timer.wait_time
		velocity += dash_speed * dash_graph.sample(progress) * direction
	
	
	move_and_slide()

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _physics_process(delta: float) -> void:
	move(delta)
	if Input.is_action_just_pressed("attack"): attack_component.attack()

func die():
	print("%s died" % name)
	hp = health
	global_position = get_random_spawn_position()

func _on_dash_exited() -> void:
	is_dashing = false

func recieve_damage(dmg: int):
	hp -= dmg
	print("%s damage taken by %s (%s hp left)" % [dmg, name, hp])
	if hp <= 0:
		die()


func get_random_spawn_position():
	if !spawn_points: return start_position
	seed(randi())
	var random_id_value = roundi(randf() * (spawn_points.get_child_count() -  1))
	return spawn_points.get_child(random_id_value).global_position
