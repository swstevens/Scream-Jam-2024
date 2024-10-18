extends Enemy
var seen : bool = false

func move(player_loc: Vector2i)->void:
	print("im trying to chase")
	#where our character is
	var enemy_loc: Vector2i = ground.local_to_map(base.to_local(global_position))
	if (enemy_loc.x == player_loc.x) or (enemy_loc.y == player_loc.y):
		print("I can see you")
		print(Vector2(player_loc-enemy_loc).normalized()) 
		direction = Vector2i(Vector2(player_loc-enemy_loc).normalized())
		var colorOfTile: Vector2i = ground.get_cell_atlas_coords(direction+enemy_loc)
		
		if TileCanBeSteppedOn(colorOfTile) and seen:
		##if the player is moving diagonally, we have to check if there are walls directly
		##adjacent to the player, so we don't move 'in between' walls to go to a corner tile.
			## also have the broadcast move to the enemies here
			print("we can move!")
			position = ground.map_to_local(direction+enemy_loc)
		seen = true
	else:
		seen = false
	#print("enemy clicked ", "enemy current")
	#print(direction)
	#
	#if not TileCanBeSteppedOn(colorOfTile):
			#print("turning around!")
			#direction.x *= -1
			#direction.y *= -1
			#colorOfTile = ground.get_cell_atlas_coords(direction+beta)
	#print("color of tile",colorOfTile)

	#return
