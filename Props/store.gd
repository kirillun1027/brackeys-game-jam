extends StaticBody2D
class_name Store

@onready var store_gui: Control = $CanvasLayer/StoreGUI
var player: Player

#const SWORD = preload("res://Weapons/sword.tres")
#const BOW = preload("res://Weapons/bow.tres")
#
#enum ItemVariants{
	#SWORD,
	#BOW
#}
#var ItemData: Dictionary = {
	#ItemVariants.SWORD : SWORD,
	#ItemVariants.BOW : BOW
#}

func _on_purchase_area_entered(body: Node2D) -> void:
	if body is Player:
		store_gui.show()
		player = body


func _on_purchase_area_exited(body: Node2D) -> void:
	if body is Player:
		player = null
		store_gui.hide()
