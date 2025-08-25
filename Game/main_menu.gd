extends Control

signal play()
signal quit()
signal settings()

const WORLD_2D: String = "res://Game/world2d.tscn"

func _on_play() -> void:
	Global.game_controller.change_scene_to(WORLD_2D, false)
