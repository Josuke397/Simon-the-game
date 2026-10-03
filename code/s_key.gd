extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" or body.has_method("collect_key"):
		body.collect_key() 
	queue_free() 
