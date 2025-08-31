extends State

var attack_speed: int = 100


func physics_update(delta: float) -> void:
	if entity is Enemy:
		entity.move(attack_speed, entity.attack_direction, delta)

func enter() -> void:
	var nav_component: NavigationComponent = get_parent().navigation_component
	nav_component.target_desired_distance /= 1.5

func exit() -> void:
	var nav_component: NavigationComponent = get_parent().navigation_component
	nav_component.target_desired_distance *= 1.5
