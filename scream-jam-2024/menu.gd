extends Control



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://basic iso.tscn")

func _on_levels_pressed() -> void:
	# hide initial screen and show the secondary one
	get_tree().change_scene_to_file("res://levels.tscn")

	pass # Replace with function body.
	
func _on_options_pressed() -> void:
	pass # Replace with function body.
	get_tree().change_scene_to_file("res://options.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()