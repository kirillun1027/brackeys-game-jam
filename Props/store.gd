extends StaticBody2D
class_name Store

@onready var store_gui: Control = $CanvasLayer/StoreGUI
var player: Player


func _on_purchase_area_entered(body: Node2D) -> void:
	if body is Player:
		store_gui.show()
		player = body


func _on_purchase_area_exited(body: Node2D) -> void:
	if body is Player:
		player = null
		store_gui.hide()
