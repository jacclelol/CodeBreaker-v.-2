extends Area2D

class_name Interactable  # <-- Důležité: Tímto vytvoříme nový typ uzlu!

func _ready():
	# Ujistíme se, že objekt jde klikat
	input_pickable = true
	
	# Propojíme signály automaticky kódem (nemusíš klikat v editoru)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
