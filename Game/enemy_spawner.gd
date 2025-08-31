extends Node

@export var safe_zone_area: Area2D
@export var ground_tilemap_layer: TileMapLayer
var spawn_region: Rect2
var safe_region: Rect2
@export var spawn_entity_scene: PackedScene
@onready var spawn_timer: Timer = $SpawnTimer
var enemy_position_list: PackedVector2Array = []

func spawn(count: int):
	for i in range(count):
		var new_entity = spawn_entity_scene.instantiate()
		add_child(new_entity)
		var set_pos: bool = false
		while !set_pos:
			randomize()
			var new_pos = Vector2(
				randf_range(spawn_region.position.x, spawn_region.end.x),
				randf_range(spawn_region.position.y, spawn_region.end.y),
				)
			if !safe_region.has_point(new_pos):
				set_pos = true
				new_entity.global_position = new_pos
				enemy_position_list.append(new_pos)
		for child in get_children():
			if child.is_in_group("enemy"):
				child.get_node("NavigationAgent2D").update_enemy_positions(enemy_position_list)

func _ready() -> void:
	call_deferred("initialize")
	for child in get_children():
		if child.is_in_group("enemy"):
			enemy_position_list.append(child.global_position)
			child.get_node("NavigationAgent2D").update_enemy_positions(enemy_position_list)

func _process(delta: float) -> void:
	pass

func _on_spawn_timeout() -> void:
	spawn(1)

func initialize():
	var tilemap_rect = ground_tilemap_layer.get_used_rect()
	spawn_region = Rect2(tilemap_rect.position * 16, tilemap_rect.size * 16)
	safe_region = safe_zone_area.get_child(0).shape.get_rect()
