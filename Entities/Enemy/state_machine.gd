extends Node
class_name StateMachine

@export var initial_state: State
@onready var active_state: State:
	set(state):
		if state:
			if state == active_state: return
			elif active_state:
				active_state.exit()
			state.enter()
			active_state = state

var states: Dictionary[StringName, State] = {}

func _ready() -> void:
	for child in get_children():
		if child is not State: continue
		child.state_machine = self
		states[child.name.to_lower()] = child
	active_state = initial_state

func _physics_process(delta: float) -> void:
	if active_state:
		active_state.physics_update(delta)

func _process(delta: float) -> void:
	if active_state:
		active_state.update(delta)

func change_state(state_name: String) -> void:
	active_state = states.get(state_name.to_lower())
	assert(active_state, "State Not Found: " + state_name)
