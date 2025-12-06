extends Node2D

@onready var player = $Player
@onready var dialog = $Player/Dialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_lamp_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):

		player.move_and_interact(get_global_mouse_position(), _start_change)

func _start_change():
	dialog.text = "Tak se převleču.."
	await get_tree().create_timer(1.5).timeout
	dialog.text = ""
	player.change_clothes()
	
