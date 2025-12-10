extends CharacterBody2D

@export var speed: float = 200.0
@onready var anim_sprite = $AnimatedSprite2D
@onready var Dialog = $Dialog/Label
var destination = Vector2()
var is_moving = false
var is_changing = false 
var pending_action: Callable = Callable()
var clothes = "pyjamas"
var is_clothed = false

func _ready() -> void:
	destination = position
	anim_sprite.play(clothes + "_idle")
	if not anim_sprite.animation_finished.is_connected(_on_animation_finished):
		anim_sprite.animation_finished.connect(_on_animation_finished)

func _unhandled_input(event):
	if is_changing:
		return
	if event.is_action_pressed("left_click"):
		pending_action = Callable() 
		destination = get_global_mouse_position()
		is_moving = true # Zapneme pohyb

func move_and_interact(target_pos: Vector2, action_to_do: Callable):
	if is_changing: return
	
	# 1. Nastavíme pohyb
	destination = target_pos
	is_moving = true
	
	# 2. Uložíme si funkci, kterou nám předmět poslal
	pending_action = action_to_do


func _physics_process(_delta):
	if is_changing:
		return
	if is_moving:
		if position.distance_to(destination) > 5:
			var direction = position.direction_to(destination)
			velocity = direction * speed
			move_and_slide()
			update_animation(direction)
			
			# Kontrola kolize se zdí (viz předchozí dotaz)
			if get_slide_collision_count() > 0 and velocity.length() < 10:
				stop_movement()
		else:
			stop_movement()
			
func stop_movement():
	if is_changing:
		return
	velocity = Vector2.ZERO
	is_moving = false

	anim_sprite.play(clothes + "_idle")
	if pending_action.is_valid():
		pending_action.call()
		pending_action = Callable() 


func update_animation(dir: Vector2):
	if is_changing:
		return
	var dir_name = ""
	

	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			dir_name = clothes + "_right"
		else:
			dir_name = clothes + "_left"
	else:
		# Jinak jdeme nahoru nebo dolů
		if dir.y > 0:
			dir_name = clothes + "_down"
		else:
			dir_name = clothes + "_up"

	anim_sprite.play(dir_name)

func change_clothes():

	is_moving = false
	velocity = Vector2.ZERO
	

	is_changing = true
	

	anim_sprite.play("pyjamas_change")


func _on_animation_finished() -> void:

	
	if anim_sprite.animation == "pyjamas_change":
		anim_sprite.play("clothes_reveal")
	elif anim_sprite.animation == "clothes_reveal":
		is_changing = false
		clothes = "normal"
		is_clothed = true
		anim_sprite.play(clothes + "_idle")

func show_dialog(text, time):
	Dialog.text = text
	await get_tree().create_timer(time).timeout
	Dialog.text = ""
	
