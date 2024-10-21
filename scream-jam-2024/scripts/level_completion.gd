extends Node

var level_completed : Array[int] = []



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_completed.push_back(1)
	for i in range(15):
		level_completed.push_back(0)
	print(level_completed)
	pass # Replace with function body.


func updateLevelComplete(level:int) -> void:
	if level_completed[level-1] != 2:
		level_completed[level-1] = 1

func updateLevelCompleteFog(level:int) -> void:
	level_completed[level-1] = 2
