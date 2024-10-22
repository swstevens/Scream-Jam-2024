extends Node

var level_completed : Array[int] = []
var fog_of_war : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#level_completed.push_back(1)
	for i in range(20):
		level_completed.push_back(0)
	print(level_completed)
	pass # Replace with function body.


func updateLevelComplete(level:int) -> void:
	if fog_of_war:
		level_completed[level-1] = 2
	else:
		level_completed[level-1] = 1
