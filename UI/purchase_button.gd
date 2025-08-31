extends Button
class_name PurchaseButton

func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)\
	 and get_global_mouse_position().x <= global_position.x + size.x*1\
	 and get_global_mouse_position().y <= global_position.y + size.y*1\
	 and get_global_mouse_position().x >= global_position.x - size.x*0\
	 and get_global_mouse_position().y >= global_position.y - size.y*0:
		pressed.emit()
