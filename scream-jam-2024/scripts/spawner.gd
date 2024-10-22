extends Node2D

const ENEMY_DUMB = preload("res://scenes/entities/enemy_dumb.tscn")
const ENEMY_SMART = preload("res://scenes/entities/enemy_smart.tscn")

@export var timer_limit = 5
@export var counter = 0
@export var isChaser = false
@export var maxSpawns = 0
var totalSpawns = 0

@onready var animated_sprite_2d: AnimatedSprite2D = $"AnimatedSprite2D"

@export var direction = Vector2i(1,0)

@onready var ground: TileMapLayer = $"../Ground"
@onready var base: Node2D = $".."

var id_num = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if timer_limit == counter:
		if animated_sprite_2d:
			animated_sprite_2d.show()
	else:
		if animated_sprite_2d:
			animated_sprite_2d.hide()
	position = ground.map_to_local(ground.local_to_map(base.to_local(global_position)))

func move(player_loc: Vector2i)->void:
	if totalSpawns < maxSpawns:
		if counter == timer_limit:
			var instance
			if isChaser:
				instance = ENEMY_SMART.instantiate()
			else:
				instance = ENEMY_DUMB.instantiate()
			instance.position = position
			instance.name = "enemy_"+name+str(id_num)
			instance.direction = direction
			id_num+=1
			get_parent().add_child(instance)
			print("GOGOGO")
			counter = 0
		else:
			counter +=1
		if timer_limit == counter:
			if animated_sprite_2d:
				animated_sprite_2d.show()
		else:
			if animated_sprite_2d:
				animated_sprite_2d.hide()
		print("timer ",counter)
		totalSpawns += 1
		pass
