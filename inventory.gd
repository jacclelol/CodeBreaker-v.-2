extends CanvasLayer

var inventory = [null, null, null, null]
var current_scene_path: String

func _process(delta: float) -> void:
	pass
	
func _ready() -> void:
	visible = false
	current_scene_path = get_tree().current_scene.get_path()
	print("Aktuální cesta scény: ", current_scene_path)
func _input(event):
	if event.is_action_pressed("open_inv"): 
		if PauseMenu.visible or current_scene_path == "/root/StartMenu":
			print("nejde...")
			return
		else:
			toggle_inv()

func toggle_inv():
	visible = not visible
	
	get_tree().paused = visible
