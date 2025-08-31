extends ProgressBar

var player_offset: Vector2 = Vector2(20,-60)
var mouse_offset: Vector2 = Vector2(20,-60)
@onready var world: Node2D = get_tree().current_scene.get_child(0)

func _process(delta: float) -> void:
	#global_position = world.player.global_position + player_offset
	global_position = get_global_mouse_position() + mouse_offset
	if value == 1: hide()
	else: show()
