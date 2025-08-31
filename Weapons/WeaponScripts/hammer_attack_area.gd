extends Area2D

var radius: float = 16/2 + 16*2 # 2 Tile Radius
var precision: int = 31
#var time: float = get_parent().lifetime_timer# if get_parent().has_node("LifetimeTimer") else 5
var framerate: int = 10
var passed_time: float = 0
var laps: int = 0
var offset: Vector2 = Vector2(10,0)

@onready var line: Line2D = $Line2D
@onready var attack_timer: Timer = $AttackTimer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	attack_timer.wait_time = get_parent().lifetime_timer.wait_time if get_parent().has_node("LifetimeTimer") else 1
	attack_timer.start()

func update_line(new_radius: float):
	line.clear_points()
	for i in range(precision + 1):
		var angle = 2 * PI * i / precision
		var coords = offset + Vector2(cos(angle), sin(angle)) * new_radius
		line.add_point(coords)
	collision_shape_2d.shape.radius = new_radius


func _physics_process(delta: float) -> void:
	if attack_timer.wait_time - attack_timer.time_left < 0: return
	update_line((attack_timer.wait_time - attack_timer.time_left) / attack_timer.wait_time * radius)


func _on_attack_timeout() -> void:
	queue_free()
