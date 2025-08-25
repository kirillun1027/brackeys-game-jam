extends Node
class_name GameController

var current_scene: Node

func _ready() -> void:
	Global.game_controller = self
	current_scene = $MainMenu
	

func change_scene_to(scene: String, delete_current: bool = true, keep_running: bool = false):
	if delete_current:
		current_scene.queue_free()
	elif keep_running:
		current_scene.hide()
	else:
		remove_child(current_scene)
	var new = load(scene).instantiate()
	add_child(new)
	current_scene = new
