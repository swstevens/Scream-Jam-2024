extends Enemy

func move(player_loc: Vector2i)->void:
	print("im trying")
	#where our character is
	var beta: Vector2i = ground.local_to_map(base.to_local(global_position))
	print("enemy clicked ", "enemy current")
	print(direction,beta)
	
	var colorOfTile: Vector2i = ground.get_cell_atlas_coords(direction+beta)
	if not TileCanBeSteppedOn(colorOfTile):
			print("turning around!")
			while not TileCanBeSteppedOn(colorOfTile):
				print("updating direction", direction)
				if direction.y:
					direction.y *= -1
				var temp = direction.x
				direction.x = direction.y
				direction.y = temp
				colorOfTile = ground.get_cell_atlas_coords(direction+beta)
				print(colorOfTile)
			print("our Final direction",direction)
			#colorOfTile = ground.get_cell_atlas_coords(direction+beta)
	print("color of tile",colorOfTile)
	if TileCanBeSteppedOn(colorOfTile):
		#if the player is moving diagonally, we have to check if there are walls directly
		#adjacent to the player, so we don't move 'in between' walls to go to a corner tile.
		# also have the broadcast move to the enemies here
		print("we can move!")
		position = ground.map_to_local(direction+beta)
	return
