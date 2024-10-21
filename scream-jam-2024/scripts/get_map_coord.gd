extends Node2D

@onready var Player: Node2D = $"player"
@onready var Ground: TileMapLayer = $"Ground"
var normalWalkTile: Vector2i = Vector2i(0,0)

@export var maxLevelScore: int = 0
@export var levelScoreDecliner: int = 0

@onready var next: Button = $UI/VBoxContainer/Next
@onready var retry: Button = $UI/VBoxContainer/Retry
@onready var levels: Button = $UI/VBoxContainer/Levels
@onready var dead_text: Label = $UI/dead
@onready var won_text: Label = $UI/won

@export var level_number = 1

var key1Pressed = false
@export var key1Tile: Vector2i = Vector2i(0, 0)
@export var door1Tile: Vector2i = Vector2i(0, 0)
@export var keydoorActive = false

@export var teleporterA1 = Vector2i(0, 0)
@export var teleporterA2 = Vector2i(0, 0)
@export var teleporterActive = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Score.isFirstTimeLoadingLevel:
		Score.levelScore = maxLevelScore
		Score.SetLevelHasBeenLoaded()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var PlayerPos: Vector2i = Ground.local_to_map(to_local(Player.global_position))
	if keydoorActive and PlayerPos == key1Tile:
		if key1Pressed == false:
			Ground.set_cell(door1Tile, 0, normalWalkTile, 0)
		key1Pressed = true

func won() -> void:
	level_completion.level_completed[level_number-1] = 1
	Player.set_process_input(false)
	won_text.show()
	next.show()
	levels.show()

func lost() -> void:
	Player.set_process_input(false)
	dead_text.show()
	retry.show()
	levels.show()

func teleportPlayerTo() -> Vector2i:
	if teleporterActive:
		match Ground.local_to_map(Player.position):
			teleporterA1:
				return teleporterA2
			teleporterA2:
				return teleporterA1
			_:
				# shouldn't hit this
				return Ground.local_to_map(Player.position)
	return Ground.local_to_map(Player.position)
