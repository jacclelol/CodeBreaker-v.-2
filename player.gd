extends CharacterBody2D

@export var speed: float = 200.0
@onready var anim_sprite = $AnimatedSprite2D
var destination = Vector2()
var is_moving = false
var last_direction_name = "down" # Pamatujeme si, kam koukal naposled

func _ready() -> void:
	destination = position
	anim_sprite.play("idle_front")

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
			update_animation(direction)
			
			# Kontrola kolize se zdí (viz předchozí dotaz)
			if get_slide_collision_count() > 0 and velocity.length() < 10:
				stop_movement()
		else:
			stop_movement()
			
func stop_movement():
	velocity = Vector2.ZERO
	is_moving = false

	anim_sprite.play("idle_front")

func update_animation(dir: Vector2):
	var dir_name = ""
	
	# Zjistíme horizontální směr (Vlevo/Vpravo)
	if dir.x > 0.3:
		dir_name += "right"
	elif dir.x < -0.3:
		dir_name += "left"
		
	# Zjistíme vertikální směr (Nahoru/Dolů)
	if dir.y > 0.3:
		if dir_name != "": dir_name = "down_" + dir_name # Diagonála (např. down_right)
		else: dir_name = "down"
	elif dir.y < -0.3:
		if dir_name != "": dir_name = "up_" + dir_name # Diagonála (např. up_right)
		else: dir_name = "up"
	
	# Pokud jsme nenašli výrazný směr (velmi malý pohyb), použijeme poslední známý
	if dir_name == "":
		dir_name = last_direction_name

	# Uložíme si směr pro příště (až se zastaví)
	last_direction_name = dir_name
	
	# Spustíme animaci chůze
	# Název musí odpovídat tomu v editoru! (např. "walk_down_right")
	anim_sprite.play("walk_" + dir_name)
