class_name GardenBed
extends Node2D

var state = Types.GARDEN_BED_STATES.EMPTY

const Beet = preload("res://scenes/Beet.tscn")
var plant: Plant = null

func get_plant() -> Plant:
	return plant

func to_plant(seed_plant):
	if state != Types.GARDEN_BED_STATES.BUSY:
		match seed_plant:
			Types.ITEMS.SEED_BEET:
				plant = Beet.instance()
				add_child(plant)
				state = Types.GARDEN_BED_STATES.BUSY
				return true

	return false

func water():
	plant.water()

func harvest() -> Food:
	state = Types.GARDEN_BED_STATES.EMPTY
	var fruit = plant.harvest()
	plant.queue_free()
	plant = null
	
	return fruit
