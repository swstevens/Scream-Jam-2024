extends Node2D

@onready var ground: TileMapLayer = $"../Ground"
@onready var base: Node2D = $".."
@onready var animations = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _input(event):
	if event.is_action_pressed("move") == false:
		return
	
	#where we clicked
	var apple: Vector2i = ground.local_to_map(base.to_local(get_global_mouse_position()))
	#where our character is
	var beta: Vector2i = ground.local_to_map(base.to_local(global_position))
	print("clicked ", "current")
	print(apple,beta)
	
	if abs(apple.x - beta.x) <= 1 and abs(apple.y - beta.y) <= 1:
		updateAnimation(Vector2i(apple.x - beta.x, apple.y - beta.y))
		var colorOfTile: Vector2i = ground.get_cell_atlas_coords(ground.local_to_map(base.to_local(get_global_mouse_position())))
		if TileCanBeSteppedOn(colorOfTile):
			#if the player is moving diagonally, we have to check if there are walls directly
			#adjacent to the player, so we don't move 'in between' walls to go to a corner tile.
			if (apple.x != beta.x) and (apple.y != beta.y):
				var adjTile1Color: Vector2i = ground.get_cell_atlas_coords(Vector2i(apple.x, beta.y))
				var adjTile2Color: Vector2i = ground.get_cell_atlas_coords(Vector2i(beta.x, apple.y))
				#if either tile cannot be stepped on, early return before we update the position
				if !TileCanBeSteppedOn(adjTile1Color) or !TileCanBeSteppedOn(adjTile2Color):
					return
			# also have the broadcast move to the enemies here
			position = ground.map_to_local(ground.local_to_map(base.to_local(get_global_mouse_position())))
			
func updateAnimation(MovementVector: Vector2i):
	var animationString: String = "walk "
	print(MovementVector.x, MovementVector.y)
	if MovementVector.x == 1 and MovementVector.y == 1:
		animationString += "down"
	elif MovementVector.x == 0 and MovementVector.y == 1:
		animationString += "downleft"
	elif MovementVector.x == -1 and MovementVector.y == 1:
		animationString += "left"
	elif MovementVector.x == -1 and MovementVector.y == 0:
		animationString += "upleft"
	elif MovementVector.x == -1 and MovementVector.y == -1:
		animationString += "up"
	elif MovementVector.x == 0 and MovementVector.y == -1:
		animationString += "upright"
	elif MovementVector.x == 1 and MovementVector.y == -1:
		animationString += "right"
	else:
		animationString += "downright"
		
	animations.play(animationString)
	
func TileCanBeSteppedOn(tile: Vector2i) -> bool:
	#so far no tiles in y coord
	match(tile.x):
		1, 3:
			#red tile
			return false
		2:
			#this will be a part of an actual event system but i hacked it here for fun
			print("You win!")
			return true
		_:
			return true
