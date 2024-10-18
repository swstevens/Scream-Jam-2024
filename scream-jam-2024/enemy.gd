extends Node2D

class_name Enemy

@export var direction: Vector2i = Vector2i(1,0)
@onready var ground: TileMapLayer = $"../Ground"
@onready var base: Node2D = $".."
@onready var nextmove: Sprite2D = $nextmove

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move(player_loc: Vector2i)->void:
	print("im trying")
	#where our character is
	var beta: Vector2i = ground.local_to_map(base.to_local(global_position))
	print("enemy clicked ", "enemy current")
	print(direction,beta)
	
	var colorOfTile: Vector2i = ground.get_cell_atlas_coords(direction+beta)
	if not TileCanBeSteppedOn(colorOfTile):
			print("turning around!")
			direction.x *= -1
			direction.y *= -1
			colorOfTile = ground.get_cell_atlas_coords(direction+beta)
	print("color of tile",colorOfTile)
	if TileCanBeSteppedOn(colorOfTile):
		#if the player is moving diagonally, we have to check if there are walls directly
		#adjacent to the player, so we don't move 'in between' walls to go to a corner tile.
		# also have the broadcast move to the enemies here
		print("we can move!")
		position = ground.map_to_local(direction+beta)
	return


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
