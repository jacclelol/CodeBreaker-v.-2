extends Node

var saved_scenes = {} 

var current_scene = null

func _ready():
	var root = get_tree().root
	current_scene = get_tree().current_scene

func change_scene(scene_path: String):
	if current_scene:
		get_tree().root.remove_child(current_scene)
		saved_scenes[current_scene.scene_file_path] = current_scene
	if saved_scenes.has(scene_path):
		current_scene = saved_scenes[scene_path]
	else:
		var new_res = load(scene_path)
		current_scene = new_res.instantiate()
	
	get_tree().root.add_child(current_scene)
	
	get_tree().current_scene = current_scene
