extends VBoxContainer
@export var next_level = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_levels_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/levels.tscn")

func _on_next_pressed() -> void:
	get_tree().change_scene_to_file(next_level)

func _on_retry_pressed() -> void:
	Score.lives = 3
	get_tree().reload_current_scene()
