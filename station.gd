extends StaticBody2D
class_name Station

var current_level_id: int = 0

@onready var collision_level_1: CollisionPolygon2D = $CollisionLevel1
@onready var collision_level_2: CollisionPolygon2D = $CollisionLevel2
@onready var collision_level_3: CollisionPolygon2D = $CollisionLevel3

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
	for child in get_children():
		if child is CollisionPolygon2D:
			child.hide()
			child.disabled = true
	update_level()

func upgrade_to(level_id: int):
	if level_id >= level_objects.size() or level_id < 0: push_error("Invalid Station Level Provided"); return
	current_level_id = level_id
	update_level()
