extends Node2D

@onready var ground: TileMapLayer = $"../Ground"
@onready var base: Node2D = $".."
@onready var move_dl: Sprite2D = $Sprite2D3 # 0,+1
@onready var move_ur: Sprite2D = $Sprite2D5 # 0,-1
@onready var move_ul: Sprite2D = $Sprite2D9 # -1,0
@onready var move_dr: Sprite2D = $Sprite2D6 # +1,0
@onready var move_r: Sprite2D = $Sprite2D7 # +1,-1
@onready var move_l: Sprite2D = $Sprite2D8 # -1,+1
@onready var move_d: Sprite2D = $Sprite2D4 # +1,+1
@onready var move_u: Sprite2D = $Sprite2D10 # -1,-1

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
			var clickStore: Vector2i = apple
			clickStore.x +=1
			if TileCanBeSteppedOn(ground.get_cell_atlas_coords(clickStore)):
				move_dr.show()
			else:
				move_dr.hide()
			
			

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
