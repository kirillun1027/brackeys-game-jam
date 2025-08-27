extends Area2D

const SPEED: int = 500
var direction: Vector2
var enemy_group: StringName = "damagable"

func _physics_process(delta: float) -> void:
	position += transform.x * SPEED * delta



func _on_body_entered(body: Node2D) -> void:
	if !body.is_in_group(enemy_group): return
	queue_free()
