extends Node2D

const ENEMY_DUMB = preload("res://scenes/entities/enemy_dumb.tscn")

@export var timer_limit = 5
@export var counter = 0

@export var direction = Vector2i(1,0)

@onready var ground: TileMapLayer = $"../Ground"
@onready var base: Node2D = $".."

var id_num = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = ground.map_to_local(ground.local_to_map(base.to_local(global_position)))

func move(player_loc: Vector2i)->void:
	if counter == timer_limit:
		var instance = ENEMY_DUMB.instantiate()
		instance.position = position
		instance.name = "enemy_dumb_"+name+str(id_num)
		instance.direction = direction
		id_num+=1
		get_parent().add_child(instance)
		print("GOGOGO")
		counter = 0
	else:
		counter +=1
	print("timer ",counter)
	pass
