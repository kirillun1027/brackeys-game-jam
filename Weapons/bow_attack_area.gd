extends Area2D

const SPEED: int = 500

func _physics_process(delta: float) -> void:
	position += transform.x * SPEED * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player: return
	queue_free()
