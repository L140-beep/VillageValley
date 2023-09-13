class_name Box
extends Node2D

onready var tilemap = $TileMap

enum STATES {
	CLOSE = 1,
	OPEN = 0
}

func open():
	var tile: Vector2 = tilemap.world_to_map(tilemap.global_position)
	tilemap.set_cellv(tile, STATES.OPEN)

func close():
	var tile: Vector2 = tilemap.world_to_map(tilemap.global_position)
	tilemap.set_cellv(tile, STATES.CLOSE)

func _physics_process(delta: float) -> void:
	close()