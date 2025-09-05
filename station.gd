extends StaticBody2D
class_name Station

var current_level_id: int = 0

@onready var collision_level_1: CollisionPolygon2D = $CollisionLevel1
@onready var collision_level_2: CollisionPolygon2D = $CollisionLevel2
@onready var collision_level_3: CollisionPolygon2D = $CollisionLevel3

@onready var station_gui: Control = $CanvasLayer/WorkstationGUI

@onready var level_objects: Array = [collision_level_1, collision_level_2, collision_level_3]

func update_level() -> void:
	for i in range(level_objects.size()):
		if i == current_level_id: 
			level_objects[i].show()
			level_objects[i].disabled = false
		else: 
			level_objects[i].hide()
			level_objects[i].disabled = true

func _ready() -> void:
	station_gui.hide()
	for child in get_children():
		if child is CollisionPolygon2D:
			assert(child.has_node("InteractionArea"), "NullPointer Workstation")
			child.get_node("InteractionArea").body_entered.connect(_on_body_entered)
			child.get_node("InteractionArea").body_exited.connect(_on_body_exited)
			child.hide()
			child.disabled = true
	update_level()

func upgrade_to(level_id: int):
	if level_id >= level_objects.size() or level_id < 0: push_error("Invalid Station Level Provided"); return
	current_level_id = level_id
	update_level()

func _on_body_entered(body: Node) -> void:
	if body is not Player: return
	station_gui.show()

func _on_body_exited(body: Node) -> void:
	if body is not Player: return
	station_gui.hide()
