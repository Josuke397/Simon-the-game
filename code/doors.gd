extends Area2D
@export_file("*.tscn") var next_scene_path: String
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if body.has_key == true:
			print("The door has opened..")
			if next_scene_path != "":
				get_tree().change_scene_to_file(next_scene_path)
			else:
				print("The door won't budge.")
