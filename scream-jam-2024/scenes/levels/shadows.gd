extends TileMapLayer
@onready var ground: TileMapLayer = $"../Ground"

var cells

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cells = ground.get_used_cells()
	for cell in cells:
		set_cell(Vector2i(cell.x,cell.y),0,Vector2i(7,0),0)
	pass # Replace with function body.

func update_shadows(player_loc: Vector2i) -> void:
	for i in range(-4,5):
		for j in range(-4,5):
			print(i,j)
			var checking : Vector2i = Vector2i(player_loc.x + i,player_loc.y + j)
			if abs(i) + abs(j) <= 3:
				set_cell(checking,0,Vector2i(7,1),0)
			else:
				if (checking in cells):
					set_cell(checking,0,Vector2i(7,0),0)
	pass
