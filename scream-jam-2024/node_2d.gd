extends Node2D

@onready var ground: TileMapLayer = $"../Ground"
@onready var base: Node2D = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _input(event):

	if event.is_action_pressed("move") == false:
		return
	var apple: Vector2i = ground.local_to_map(base.to_local(get_global_mouse_position()))
	var beta: Vector2i = ground.local_to_map(base.to_local(global_position))
	print(apple,beta)
	if abs(apple.x - beta.x) <= 1 and abs(apple.y - beta.y) <= 1:
		# also have the broadcast move to the enemies here
		# check for collisions
		position = ground.map_to_local(ground.local_to_map(base.to_local(get_global_mouse_position())))
		
