extends Node2D

@onready var player = $Player

var arrow = load("res://icon.svg")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_postel_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		Inventory.add_to_inv("figurka")


func _on_vesak_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		player.move_and_interact(get_global_mouse_position(), _start_change)
		


func _on_bookshelf_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
		if event.is_action_pressed("left_click"):
			player.move_and_interact(get_global_mouse_position(), func(): await player.show_dialog("Moje polička...", 2))
func _start_change():
	if !player.is_clothed:
		player.show_dialog("Převleču se...", 5)
		player.change_clothes()
	else:
		player.show_dialog("Už jsem převlečen...", 2)
