extends CharacterBody2D

@export var speed: float = 200.0
var destination = Vector2()
var is_moving = false

func _ready() -> void:
	destination = position

func _unhandled_input(event):
	if event.is_action_pressed("left_click"):
		destination = get_global_mouse_position()
		is_moving = true # Zapneme pohyb

func _physics_process(_delta):
	if is_moving:
		if position.distance_to(destination) > 5:
			var direction = position.direction_to(destination)
			velocity = direction * speed
			move_and_slide()
		else:
			velocity = Vector2.ZERO
			is_moving = false
