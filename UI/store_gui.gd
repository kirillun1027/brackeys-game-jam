extends Control
class_name StoreGUI

@onready var sold_out_label: Label = $SoldOutLabel

func _ready() -> void:
	for child in get_children():
		if child is VBoxContainer and child.get_child(0) is ItemDisplayRow:
			child.get_child(0).item_purchased.connect(on_child_disconnected)

func on_child_disconnected():
	if get_child_count() == 1:
		sold_out_label.show()
