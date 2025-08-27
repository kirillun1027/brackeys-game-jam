extends NavigationAgent2D
class_name NavigationComponent

var speed: int = 100
var range = 100

func _ready() -> void:
	target_desired_distance = range


func _physics_process(delta: float) -> void:
	if !get_tree().current_scene.get_child(0).player: return
	if distance_to_target() <= neighbor_distance and avoidance_enabled == false:
		avoidance_enabled = true
	elif distance_to_target() > neighbor_distance and avoidance_enabled == true:
		avoidance_enabled = false
	target_position = get_tree().current_scene.get_child(0).player.global_position
	var current_position = get_parent().global_position
	var next_path_position = get_next_path_position()
	velocity = current_position.direction_to(next_path_position)


func _on_velocity_computed(safe_velocity: Vector2) -> void:
	if is_target_reached():
		var retreat_direction: Vector2 = target_position.direction_to(get_parent().global_position)
		get_parent().velocity = retreat_direction * speed
	else:
		get_parent().velocity = safe_velocity * speed
		
	get_parent().move_and_slide()


func _on_target_reached() -> void:
	target_desired_distance = range * 1.2


func _on_path_changed() -> void:
	target_desired_distance = range
