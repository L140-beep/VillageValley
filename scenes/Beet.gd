extends Node2D

var stage = 0
onready var tile_pos = $Position2D
onready var tile_map = $TileMap




func _timeout(time):
	var tile: Vector2 = tile_map.world_to_map(tile_pos.global_position)
	tile_map.set_cellv(tile, stage)
	stage = (stage + 1) % 5
