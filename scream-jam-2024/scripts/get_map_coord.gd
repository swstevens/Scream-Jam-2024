extends Node2D

@onready var Player: Node2D = $"player"
@onready var Ground: TileMapLayer = $"Ground"
var normalWalkTile: Vector2i = Vector2i(0,0)

@export var maxLevelScore: int = 0
@export var levelScoreDecliner: int = 0

var key1Pressed = false
@export var key1Tile: Vector2i = Vector2i(0, 0)
@export var door1Tile: Vector2i = Vector2i(0, 0)
@export var keydoorActive = false

@export var teleporterA1 = Vector2i(0, 0)
@export var teleporterA2 = Vector2i(0, 0)
@export var teleporterActive = false

@export var backgroundMusicTrack = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Score.isFirstTimeLoadingLevel:
		Score.levelScore = maxLevelScore
		Score.SetLevelHasBeenLoaded()
	playBackgroundMusic()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var PlayerPos: Vector2i = Ground.local_to_map(to_local(Player.global_position))
	if keydoorActive and PlayerPos == key1Tile:
		if key1Pressed == false:
			Ground.set_cell(door1Tile, 0, normalWalkTile, 0)
			$"Door".play()
		key1Pressed = true

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

func playBackgroundMusic():
	match backgroundMusicTrack:
		1:
			$"8-bit-adventure".play()
		2:
			$"8-bit-determination".play()
		3:
			$"8-bit-groove".play()
		4:
			$"8-bit-mountains-ahead".play()
		5:
			$"8-bit-shadows".play()
		6:
			$"8-bit-success".play()
		_:
			pass

func stopBackgroundMusic():
	match backgroundMusicTrack:
		1:
			$"8-bit-adventure".stop()
		2:
			$"8-bit-determination".stop()
		3:
			$"8-bit-groove".stop()
		4:
			$"8-bit-mountains-ahead".stop()
		5:
			$"8-bit-shadows".stop()
		6:
			$"8-bit-success".stop()
		_:
			pass
