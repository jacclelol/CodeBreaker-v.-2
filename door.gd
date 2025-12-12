class_name door extends Node2D

@export_file("*.tscn") var target_scene_path: String

func NextScene(scene_path: String):
	if scene_path == "":
		print("Chyba: Prázdná cesta")
		return
		
	SceneManager.change_scene(scene_path)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		NextScene(target_scene_path)
		print(target_scene_path)
