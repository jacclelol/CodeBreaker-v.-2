extends CanvasLayer

var items = [null, null, null, null, null, null, null, null]
const slots_count = 8
var free_slot: int

func check_slot():
	for i in 8:
		if items[i] == null:
			print("volny slot")
			free_slot = i
			return
		else:
			print("plny slot")
			free_slot = -1

func add_to_inv(item: String):
	check_slot()
	if free_slot != -1:
		update_visuals(item, free_slot)
		items[free_slot] = item
		print("Volny slot je",  free_slot)
	else:
		print("neni volny slot")

var slot_path
var slot_node

func update_visuals(item: String, free_slot: int):
	slot_path = "Control/ColorRect/slot" + str(free_slot)
	slot_node = get_node(slot_path)
	slot_node.texture = load("res://icon.svg")

var selected
func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		for i in get_child_count():
			var slot = get_child(i)
			
			# Je to opravdu TextureRect? (pro jistotu)
			if slot is TextureRect:
				
				# MAGIE:
				# get_global_rect() vrátí obdélník slotu na obrazovce.
				# has_point() zkontroluje, jestli je myš uvnitř.
				if slot.get_global_rect().has_point(event.global_position):
					
					print("Klikl jsi na TextureRect (slot) č.: ", i)
					selected.emit(i)
					return
		


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
		current_scene_path = get_tree().current_scene.get_path()
		if PauseMenu.visible or current_scene_path == "/root/StartMenu":
			print("nejde...")
			return
		else:
			toggle_inv()

func toggle_inv():
	visible = not visible
	
	get_tree().paused = visible


	
