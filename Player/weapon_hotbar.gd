extends Panel

var items: Array[Weapon] = []
@export var player: Player
@onready var slot_container: HBoxContainer = $HotbarSlotContainer
@onready var item_select_frame: TextureRect = $ItemSelectFrame
const WEAPON_ICON = preload("res://Items/weapon_icon.tscn")
var item_positions: Dictionary[Weapon, Vector2] = {}
@onready var frame_init_pos = global_position
var frame_offset: Vector2 = Vector2(size.y/2, size.y/2)

func update_hotbar():
	var player_weapons: Array[Weapon] = player.attack_component.available_weapons
	var selected_weapon: Weapon = player.attack_component.active_weapon
	
	#if items == player_weapons: return
	var items_to_include: Array[Weapon]
	
	for item: Weapon in player_weapons:
		if not item in items:
			items.append(item)
			var weapon_slot: TextureRect = WEAPON_ICON.instantiate()
			slot_container.add_child(weapon_slot)
			weapon_slot.texture = item.icon
			weapon_slot.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			weapon_slot.size_flags_vertical = Control.SIZE_EXPAND_FILL
			item_positions.set(item, weapon_slot.global_position) 
		if item == selected_weapon:
			item_select_frame.global_position = frame_init_pos + Vector2(size.y * (items.find(item) - 1), 0)
	size.x = slot_container.get_child_count() * size.y
	slot_container.size.x = slot_container.get_child_count() * size.y

func _ready() -> void:
	call_deferred("initialize")

func initialize():
	update_hotbar()
	item_select_frame.global_position = frame_init_pos - Vector2(size.y * 0.5, 0)# + frame_offset
	player.attack_component.weapons_updated.connect(update_hotbar)
