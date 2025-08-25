extends CharacterBody2D

var hp = 5
@onready var animation_timer: Timer = $AnimationTimer
@onready var original_modulate = modulate

func recieve_damage(dmg: int) -> void:
	hp -= dmg
	if hp <= 0:
		queue_free()
		return
	animation_timer.start()
	modulate = Color("RED")



func _on_animation_timeout() -> void:
	modulate = original_modulate
