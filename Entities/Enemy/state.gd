class_name State extends Node

var state_machine: StateMachine
@onready var entity: Node = get_parent().get_parent()

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
