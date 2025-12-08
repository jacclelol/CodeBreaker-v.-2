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

var base_path = "Control/ColorRect/slot"
var slot_node

func update_visuals(item: String, free_slot: int):
	var slot_path = base_path + str(free_slot)
	slot_node = get_node(slot_path)
	slot_node.texture = load("res://icon.svg")

var selected = ""
func selection(selected_index: int):
	for n in 8:
		var slot_path = base_path + str(n) + "/ColorRect"
		slot_node = get_node(slot_path)
		if selected_index == n and items[selected_index] != null:
			slot_node.color = Color(0.44, 0.774, 0.4, 1.0)
			selected = items[selected_index]
			print(selected)
		else:
			slot_node.color = Color.GRAY
		
var selected_index = -1
func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		for i in range($Control/ColorRect.get_child_count()):
			var slot = $Control/ColorRect.get_child(i)

			if slot is TextureRect:
				if slot.get_global_rect().has_point(event.global_position):
					print("Klikl jsi na slot s indexem: ", i)
					selected_index = i
					selection(selected_index)
					return


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
	selection(-1)
	get_tree().paused = visible


	
