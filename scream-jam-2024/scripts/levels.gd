extends Control



func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/menu.tscn")


func _on_button1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")
