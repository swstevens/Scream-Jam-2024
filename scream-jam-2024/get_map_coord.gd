extends Node2D

@onready var Player: Node2D = $"player"
@onready var Ground: TileMapLayer = $"Ground"

# key1 = 1, -4 : door1 = 4, -4
var key1Pressed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var PlayerPos: Vector2 = Ground.local_to_map(to_local(Player.global_position))
	if PlayerPos.x == 1 and PlayerPos.y == -4:
		if key1Pressed == false:
			Ground.set_cell(Vector2i(4, -4), 0, Vector2i(0, 0), 0)
		key1Pressed = true
		print("Found key!")
	pass
