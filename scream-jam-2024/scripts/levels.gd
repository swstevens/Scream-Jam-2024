extends Control
@onready var fog_of_war: Button = $"MarginContainer/Fog of War"

func _ready() -> void:
	Score.lives = 3
	if level_completion.fog_of_war:
		fog_of_war.text = "Fog of War: On"
	else:
		fog_of_war.text = "Fog of War: Off"

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/menu.tscn")

func _on_button1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")

func _on_button_2_pressed() -> void:
	if level_completion.level_completed[0] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level2.tscn")

func _on_button_3_pressed() -> void:
	if level_completion.level_completed[1] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level3.tscn")


func _on_button_4_pressed() -> void:
	if level_completion.level_completed[2] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level4.tscn")


func _on_button_5_pressed() -> void:
	if level_completion.level_completed[3] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level5.tscn")


func _on_button_6_pressed() -> void:
	if level_completion.level_completed[4] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level6.tscn")


func _on_button_7_pressed() -> void:
	if level_completion.level_completed[5] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level7.tscn")


func _on_button_8_pressed() -> void:
	if level_completion.level_completed[6] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level8.tscn")


func _on_button_9_pressed() -> void:
	if level_completion.level_completed[7] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level9.tscn")


func _on_button_10_pressed() -> void:
	if level_completion.level_completed[8] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level10.tscn")


func _on_button_11_pressed() -> void:
	if level_completion.level_completed[9] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level11.tscn")


func _on_button_12_pressed() -> void:
	if level_completion.level_completed[10] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level12.tscn")


func _on_button_13_pressed() -> void:
	if level_completion.level_completed[11] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level13.tscn")


func _on_button_14_pressed() -> void:
	if level_completion.level_completed[12] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level14.tscn")


func _on_button_15_pressed() -> void:
	if level_completion.level_completed[13] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level15.tscn")


func _on_button_16_pressed() -> void:
	if level_completion.level_completed[14] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level16.tscn")


func _on_button_17_pressed() -> void:
	if level_completion.level_completed[15] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level17.tscn")


func _on_button_18_pressed() -> void:
	if level_completion.level_completed[16] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level18.tscn")


func _on_button_19_pressed() -> void:
	if level_completion.level_completed[17] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level19.tscn")


func _on_button_20_pressed() -> void:
	if level_completion.level_completed[18] != 0:
		get_tree().change_scene_to_file("res://scenes/levels/level20.tscn")


func _on_button_fow_pressed() -> void:
	if level_completion.fog_of_war:
		level_completion.fog_of_war = false
		fog_of_war.text = "Fog of War: Off"
	else:
		level_completion.fog_of_war = true
		fog_of_war.text = "Fog of War: On"
		
