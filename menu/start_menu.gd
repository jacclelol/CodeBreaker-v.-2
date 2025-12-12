extends CanvasLayer


func _on_start_pressed() -> void:
	SceneManager.change_scene("res://scenes/1/main_scene.tscn")


func _on_end_pressed() -> void:
	get_tree().quit()
