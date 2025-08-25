extends Node2D

const MAIN_MENU: String = "res://Game/main_menu.tscn"

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("leave"):
		Global.game_controller.change_scene_to(MAIN_MENU, false)
