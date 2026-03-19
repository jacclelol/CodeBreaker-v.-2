extends Node2D # Necháme Node2D jak jsi chtěl

@export_file("*.tscn") var target_scene_path: String

# Tuto funkci zavolá hráč, až dojde ke dveřím
func change_scene_action():
	if target_scene_path == "":
		print("Chyba: Prázdná cesta")
		return
	SceneManager.change_scene(target_scene_path)

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var player = get_tree().get_first_node_in_group("player")
		
		if player:
			if PlayerData.maobleceni:
				player.move_and_interact(global_position, Callable(self, "change_scene_action"))
			else:
				var dialog_akce = Callable(player, "show_dialog").bind("Nemám oblečení!", 2)
				player.move_and_interact(global_position, dialog_akce)

				
		else:
			print("Chyba: Hráč nebyl nalezen ve skupině 'Player'")
