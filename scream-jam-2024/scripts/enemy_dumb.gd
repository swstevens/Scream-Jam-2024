extends Enemy

func move(player_loc: Vector2i)->void:
	print("im trying")
	#where our character is
	var beta: Vector2i = ground.local_to_map(base.to_local(global_position))
	print("enemy clicked ", "enemy current")
	print(direction,beta)
	
	var colorOfTile: Vector2i = ground.get_cell_atlas_coords(direction+beta)
	if not TileCanBeSteppedOn(colorOfTile):
			print("I've gone as far as I can, so long")
			queue_free()
	if TileCanBeSteppedOn(colorOfTile):
		#if the player is moving diagonally, we have to check if there are walls directly
		#adjacent to the player, so we don't move 'in between' walls to go to a corner tile.
		# also have the broadcast move to the enemies here
		print("we can move!")
		position = ground.map_to_local(direction+beta)
	updateNextMove() 
	return
