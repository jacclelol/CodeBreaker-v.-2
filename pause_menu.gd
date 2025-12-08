extends CanvasLayer


var current_scene: String

func _on_ready() -> void:
	visible = false # Po startu menu schováme
	current_scene = get_tree().current_scene.get_path()

func _input(event):
	if event.is_action_pressed("ui_cancel"): # Obvykle ESC
		current_scene = get_tree().current_scene.get_path()
		if Inventory.visible and current_scene != "/root/StartMenu":
			Inventory.visible = false
			toggle_pause()
		elif current_scene == "/root/StartMenu":
			get_tree().quit()
		else:
			toggle_pause()

func toggle_pause():
	# Přepneme viditelnost
	visible = not visible
	
	# Zastavíme/Spustíme hru
	get_tree().paused = visible


func _on_resume_pressed() -> void:
	visible = not visible
	get_tree().paused = visible


func _on_end_pressed() -> void:
	get_tree().quit()
