extends StateMachine
class_name EnemyStateMachine

@onready var navigation_component: NavigationComponent = $"../NavigationAgent2D"


func _process(delta: float) -> void:
	if navigation_component.is_target_reached()\
	 and active_state != states.get("retreat"):
		change_state("retreat")

	elif !navigation_component.is_target_reached()\
	 and !navigation_component.player.is_in_safe_zone\
	 and navigation_component.is_target_reachable()\
	 and active_state != states.get("attack"):
		change_state("attack")

	elif (!navigation_component.is_target_reachable()\
	 or navigation_component.player.is_in_safe_zone)\
	 and active_state != states.get("wander"):
		change_state("wander")
