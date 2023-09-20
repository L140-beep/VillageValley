class_name VillageContainer
extends Node2D

onready var tilemap = $TileMap
onready var open_positon = $OpenPosition

export(int) var capacity = 10
var size = 7

enum STATES {
	CLOSE = 1,
	OPEN = 0
}
var state = STATES.CLOSE

const seed_beet = preload("res://scenes/SeedBeet.tscn")

var items = {
	Types.ITEMS.SEED_BEET: [seed_beet.instance(), seed_beet.instance(), seed_beet.instance(), seed_beet.instance(), seed_beet.instance(), seed_beet.instance(), seed_beet.instance(), seed_beet.instance()]
}

func get_open_position():
	return open_positon

func pop_item(item_type):
	if state == STATES.OPEN:
		var item_arr: Array = items.get(item_type)
		if item_arr:
			var item: Item = item_arr.back()
			size -= item.item_size
			item_arr.pop_back()
			if item_arr.empty():
				items.erase(item_type)
			
			return item
	return null

func put_item(item: Item) -> bool:
	if state == STATES.OPEN:
		if size + item.item_size < capacity:
			if items.has(item.item_type):
				items.get(item.item_type).append(item)
			else:
				items[item.item_type] = [item]
			
			size += item.item_size
			return true
	
	return false

func has(item_type):
	return items.has(item_type)

func open() -> bool:
	var tile: Vector2 = tilemap.world_to_map(tilemap.position)
	tilemap.set_cellv(tile, STATES.OPEN)
	state = STATES.OPEN
	return true
func close():
	var tile: Vector2 = tilemap.world_to_map(tilemap.position)
	tilemap.set_cellv(tile, STATES.CLOSE)
	state = STATES.CLOSE

func is_open():
	return state == STATES.OPEN
