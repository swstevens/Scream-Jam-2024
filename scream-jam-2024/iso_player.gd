extends CharacterBody2D

@export var speed := 150.0
var target_position: Vector2
var moving := false

# Reference to your TileMap node
@onready var tilemap := $"../TileMap"

func _ready():
	target_position = position

func _process(delta: float) -> void:
	if moving:
		move_player(delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MouseButton["MOUSE_BUTTON_LEFT"]:
		var click_position = event.position
		var map_position = tilemap.world_to_map(click_position)
		target_position = tilemap.map_to_world(map_position) + tilemap.tile_set.tile_size / 2
		moving = true

func move_player(delta: float) -> void:
	var direction = (target_position - position).normalized()
	velocity = direction * speed

	if position.distance_to(target_position) < 1:
		moving = false
		velocity = Vector2.ZERO

	move_and_slide()
