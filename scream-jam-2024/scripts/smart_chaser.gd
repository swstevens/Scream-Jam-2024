extends Enemy

var astar = AStar2D.new()
var tilemap: TileMapLayer

var point_to_id = {}

func _ready():
	tilemap = get_node("../Ground")  # Adjust the path to your TileMap node
	var cells = tilemap.get_used_cells()
	
	# First pass: Add all walkable tiles as points
	var point_id = 0
	var point_to_id = {}
	for cell in cells:
		var colorOfTile: Vector2i = tilemap.get_cell_atlas_coords(cell)
		if TileCanBeSteppedOn(colorOfTile):
			print('adding tile',point_id)
			astar.add_point(point_id, tilemap.map_to_local(Vector2i(cell.x, cell.y)), 1)
			point_to_id[cell] = point_id
			point_id += 1
	
	# Second pass: Connect neighboring tiles
	for cell in cells:
		if cell in point_to_id:
			var cell_id = point_to_id[cell]
			var neighbors = [
				Vector2i(cell.x + 1, cell.y),
				Vector2i(cell.x - 1, cell.y),
				Vector2i(cell.x, cell.y + 1),
				Vector2i(cell.x, cell.y - 1)
			]
			
			for neighbor in neighbors:
				if neighbor in point_to_id:
					var neighbor_id = point_to_id[neighbor]
					if not astar.are_points_connected(cell_id, neighbor_id):
						astar.connect_points(cell_id, neighbor_id, true)
	print("help me",astar.get_point_connections(0))

func move(player_loc: Vector2i)->void:
	print("im trying to chase")
	
	##where our character is
	var enemy_loc: Vector2i = ground.local_to_map(base.to_local(global_position))
	for item in point_to_id:
		print(item)
	print(player_loc)
	print(enemy_loc)
	if player_loc not in point_to_id or enemy_loc not in point_to_id:
		print("Invalid start or end position")
		return
	#
	#if (enemy_loc.x == player_loc.x) or (enemy_loc.y == player_loc.y):
		#print("I can see you")
		#print(Vector2(player_loc-enemy_loc).normalized()) 
		#direction = Vector2i(Vector2(player_loc-enemy_loc).normalized())
		#var colorOfTile: Vector2i = ground.get_cell_atlas_coords(direction+enemy_loc)
		#
		#if TileCanBeSteppedOn(colorOfTile):
		###if the player is moving diagonally, we have to check if there are walls directly
		###adjacent to the player, so we don't move 'in between' walls to go to a corner tile.
			### also have the broadcast move to the enemies here
			#print("we can move!")
			#position = ground.map_to_local(direction+enemy_loc)
			#nextmove.global_position = ground.map_to_local(enemy_loc)
