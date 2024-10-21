extends Control
@export var level = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if level_completion.level_completed[level-1] > 0:
		
		# Create a new StyleBoxFlat to customize button appearance
		if level_completion.level_completed[level-1] == 1:
			print('level 1 is completed')
			add_theme_color_override("font_color",Color(1,0.3,0,1))

		elif level_completion.level_completed[level-1] == 2:
			print('level 1 is perfect cleared')
			add_theme_color_override("font_color",Color(1,1,0,1))


	#add_theme_color_override("font_color",Color(160,0,160))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
