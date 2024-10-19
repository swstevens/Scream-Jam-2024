extends Node2D

@onready var Player: Node2D = $"player"
@onready var Ground: TileMapLayer = $"Ground"
var normalWalkTile: Vector2i = Vector2i(0,0)

# key1 = 1, -4 : door1 = 4, -4
var key1Pressed = false
@export var key1Tile: Vector2i = Vector2i(1, -4)
@export var door1Tile: Vector2i = Vector2i(4, -4)

@export var teleporterA1 = Vector2i(-5, -1)
@export var teleporterA2 = Vector2i(-5, -4)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var PlayerPos: Vector2i = Ground.local_to_map(to_local(Player.global_position))
	if PlayerPos == key1Tile:
		if key1Pressed == false:
			Ground.set_cell(door1Tile, 0, normalWalkTile, 0)
		key1Pressed = true

func teleportPlayerTo() -> Vector2i:
	match Ground.local_to_map(Player.position):
		teleporterA1:
			return teleporterA2
		teleporterA2:
			return teleporterA1
		_:
			# shouldn't hit this
			return Ground.local_to_map(Player.position)
