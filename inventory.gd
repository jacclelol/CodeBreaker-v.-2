extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false # Po startu menu schováme


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event.is_action_pressed("open_inv"): 
		if PauseMenu.visible:
			print("nejde...")
		else:
			toggle_inv()

func toggle_inv():
	visible = not visible
	
	get_tree().paused = visible
