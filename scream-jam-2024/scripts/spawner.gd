extends Node2D
const ENEMY_DUMB = preload("res://scenes/enemy_dumb.tscn")
@export var timer_limit = 5
@export var counter = 0
var id_num = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	counter = 0

func move(player_loc: Vector2i)->void:
	if counter == timer_limit:
		var instance = ENEMY_DUMB.instantiate()
		instance.position = position
		instance.name = "enemy_dumb_"+str(id_num)
		id_num+=1
		get_parent().add_child(instance)
		print("GOGOGO")
		counter = 0
	else:
		counter +=1
	print("timer ",counter)
	pass
