extends Node2D

@onready var ground: TileMapLayer = $"../Ground"
@onready var base: Node2D = $".."
@onready var animations = $AnimationPlayer

@onready var dead: Label = $"../UI/dead"
@onready var won: Label = $"../UI/won"

@onready var move_dl: Sprite2D = $Sprite2D3 # 0,+1
@onready var move_ur: Sprite2D = $Sprite2D5 # 0,-1
@onready var move_ul: Sprite2D = $Sprite2D9 # -1,0
@onready var move_dr: Sprite2D = $Sprite2D6 # +1,0
@onready var move_r: Sprite2D = $Sprite2D7 # +1,-1
@onready var move_l: Sprite2D = $Sprite2D8 # -1,+1
@onready var move_d: Sprite2D = $Sprite2D4 # +1,+1
@onready var move_u: Sprite2D = $Sprite2D10 # -1,-1
var directions
var enemies = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	directions = [[Vector2i(0,1),move_dl],[Vector2i(0,-1),move_ur],[Vector2i(1,0),move_dr],[Vector2i(-1,0),move_ul],[Vector2i(1,1),move_d],[Vector2i(-1,1),move_l],[Vector2i(1,-1),move_r],[Vector2i(-1,-1),move_u]]
	enemies = get_tree().get_root().find_children("enemy*", "", true, false)
	print("Found ", enemies.size(), " enemies")
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
		# update the player animation based on where we clicked
		updateAnimation(Vector2i(apple.x - beta.x, apple.y - beta.y))
		
		# get the color of the tile that was clicked and see if we can step on it
		# if we can't step on it, don't move the character, but we also don't use a turn.
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
			
			# Update the position of the character to where we clicked our mouse.
			position = ground.map_to_local(apple)
			
			# Since we are moving our character, perform the enemy movements
			for enemy in enemies:
				enemy.move(apple)
			for enemy in enemies:
				if position == enemy.position:
					dead.show()
			
			# Finally, perform 'special tile' checks.
			
			# If it's a victory tile, show the victory screen.
			if colorOfTile.x == 2:
				won.show()
			# If it's a teleporter tile, update the position of the player.
			if colorOfTile.x == 5:
				position = ground.map_to_local(base.teleportPlayerTo())

			# Finally, we need to update the tile indicators so that viable next steps
			# are visible to the player. Do this after teleporting so that it's updated
			# with the new final position, not the tile that was clicked.
			var clickStore: Vector2i
			for item in directions:
				#print(item)
				clickStore = ground.local_to_map(position) + item[0]
				if TileCanBeSteppedOn(ground.get_cell_atlas_coords(clickStore)):
					if abs(item[0].x) == abs(item[0].y):
						var localPos = ground.local_to_map(position)
						var adjTile1Color: Vector2i = ground.get_cell_atlas_coords(Vector2i(localPos.x, localPos.y + item[0].y))
						var adjTile2Color: Vector2i = ground.get_cell_atlas_coords(Vector2i(localPos.x + item[0].x, localPos.y))
						if !TileCanBeSteppedOn(adjTile1Color) or !TileCanBeSteppedOn(adjTile2Color):
							item[1].hide()
							continue
					item[1].show()
				else:
					item[1].hide()

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
