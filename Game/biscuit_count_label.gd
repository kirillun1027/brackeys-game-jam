extends Label


func _ready() -> void:
	get_parent().size = size + Vector2(size.y, 0)
	get_parent().global_position.x -= 100
	get_child(0).set_deferred("size", get_parent().size)

#func extract_numbers_from(txt: String) -> Array[int]:
	#var is_registering = false
	#var res: Array[int] = []
	#var current_member: String
	#for c in txt:
		#if c.is_valid_int():
			#if is_registering: current_member += c
			#else:
				#is_registering = true
				#current_member = c
