extends CanvasLayer



func _on_ready() -> void:
	visible = false # Po startu menu schováme

func _input(event):
	if event.is_action_pressed("ui_cancel"): # Obvykle ESC
		if Inventory.visible:
			Inventory.visible = false
			toggle_pause()
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
