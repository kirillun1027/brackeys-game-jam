extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.is_in_safe_zone = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.is_in_safe_zone = false
