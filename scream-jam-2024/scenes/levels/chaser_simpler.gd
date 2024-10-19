extends Enemy

func move(player_loc: Vector2i)->void:
	print("im trying to chase")
	#where our character is
	var enemy_loc: Vector2i = ground.local_to_map(base.to_local(global_position))
	print("I can see you")
	print(Vector2(player_loc-enemy_loc).normalized()) 
	direction = Vector2i(Vector2(player_loc-enemy_loc))
	print("my chaser's direction",direction)
	if abs(direction.x) > abs(direction.y):
		direction.y=0
		print(direction)
		direction = Vector2i(Vector2(direction).normalized())
	else:
		direction.x=0
		print(direction)
		direction = Vector2i(Vector2(direction).normalized())
	print("new direction: ",direction)
	var colorOfTile: Vector2i = ground.get_cell_atlas_coords(direction+enemy_loc)
	
	if TileCanBeSteppedOn(colorOfTile):
	##if the player is moving diagonally, we have to check if there are walls directly
	##adjacent to the player, so we don't move 'in between' walls to go to a corner tile.
		## also have the broadcast move to the enemies here
		print("we can move!")
		position = ground.map_to_local(direction+enemy_loc)
		return
	var opposite : Vector2i = Vector2i(direction.y,direction.x)
	colorOfTile = ground.get_cell_atlas_coords(opposite+enemy_loc)
	if TileCanBeSteppedOn(colorOfTile):
	##if the player is moving diagonally, we have to check if there are walls directly
	##adjacent to the player, so we don't move 'in between' walls to go to a corner tile.
		## also have the broadcast move to the enemies here
		print("next best move!")
		position = ground.map_to_local(opposite+enemy_loc)
