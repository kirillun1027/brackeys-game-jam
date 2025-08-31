extends StaticBody2D

@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var outline: Line2D = $Outline
@onready var safe_zone_area: Area2D = $SafeZoneArea

var precision: int = 63
var zone_radius: float = 200


func _ready() -> void:
	collision_polygon_2d.build_mode = CollisionPolygon2D.BUILD_SEGMENTS
	safe_zone_area.get_child(0).shape.radius = zone_radius
	# Add outline
	var outline_polygon: PackedVector2Array = []
	for i in range(precision + 1):
		var angle = 2 * PI * i / precision
		var coords = Vector2(cos(angle), sin(angle)) * zone_radius
		outline.add_point(coords)
		outline_polygon.append(coords)
	collision_polygon_2d.set_polygon(outline_polygon)
	get_parent().bake_navigation_polygon()
	
