extends CanvasLayer


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://main_scene.tscn")


func _on_end_pressed() -> void:
	get_tree().quit()
