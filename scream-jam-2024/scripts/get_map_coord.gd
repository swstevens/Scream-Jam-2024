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
@onready var shadows: TileMapLayer = $shadows

@export var level_number = 1

var key1Pressed = false
var key2Pressed = false
var key3Pressed = false
@export var key1Tile: Vector2i = Vector2i(0, 0)
@export var door1Tile: Vector2i = Vector2i(0, 0)
@export var key2Tile: Vector2i = Vector2i(100, 0)
@export var door2Tile: Vector2i = Vector2i(100, 0)
@export var key3Tile: Vector2i = Vector2i(100, 0)
@export var door3Tile: Vector2i = Vector2i(100, 0)
@export var keydoorActive = false

@export var teleporterA1 = Vector2i(0, 0)
@export var teleporterA2 = Vector2i(0, 0)
@export var teleporterB1 = Vector2i(100, 0)
@export var teleporterB2 = Vector2i(100, 0)
@export var teleporterC1 = Vector2i(100, 0)
@export var teleporterC2 = Vector2i(100, 0)
@export var teleporterActive = false

@export var backgroundMusicTrack = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Score.isFirstTimeLoadingLevel:
		Score.levelScore = maxLevelScore
		Score.SetLevelHasBeenLoaded()
	playBackgroundMusic()
	if level_completion.fog_of_war and shadows:
		shadows.show()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var PlayerPos: Vector2i = Ground.local_to_map(to_local(Player.global_position))
	if keydoorActive and PlayerPos == key1Tile:
		if key1Pressed == false:
			Ground.set_cell(door1Tile, 0, normalWalkTile, 0)
			$"Door".play()
		key1Pressed = true
	if keydoorActive and PlayerPos == key2Tile:
		if key2Pressed == false:
			Ground.set_cell(door2Tile, 0, normalWalkTile, 0)
			$"Door".play()
		key2Pressed = true
	if keydoorActive and PlayerPos == key3Tile:
		if key3Pressed == false:
			Ground.set_cell(door3Tile, 0, normalWalkTile, 0)
			$"Door".play()
		key3Pressed = true

func won() -> void:
	level_completion.updateLevelComplete(level_number)
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
		$"Teleporter".play()
		match Ground.local_to_map(Player.position):
			teleporterA1:
				return teleporterA2
			teleporterA2:
				return teleporterA1
			teleporterB1:
				return teleporterB2
			teleporterB2:
				return teleporterB1
			teleporterC1:
				return teleporterC2
			teleporterC2:
				return teleporterC1
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
