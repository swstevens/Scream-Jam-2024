extends Node2D

var astar_grid: AStarGrid2D
@onready var ground: TileMapLayer = $"../Ground"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	astar_grid = AStarGrid2D.new()
	astar_grid.region = ground.get_used_rect()
	astar_grid.cell_size = Vector2(32,16)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()

func _input(event):

	if event.is_action_pressed("move") == false:
		return
	print(		ground.local_to_map(global_position),
	ground.local_to_map(get_global_mouse_position()))
	var id_path = astar_grid.get_id_path(
		ground.local_to_map(global_position),
		ground.local_to_map(get_global_mouse_position())
	)
	print(ground.map_to_local(ground.local_to_map(get_global_mouse_position())))
	position = ground.map_to_local(ground.local_to_map(get_global_mouse_position()))
	position.x -= 160
	position.y -= 120 + 8
	print(id_path)
		
