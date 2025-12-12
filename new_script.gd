class_name Door extends Area2D

func NextScene(scene_path: String):
	get_tree().change_scene_to_file(scene_path)
