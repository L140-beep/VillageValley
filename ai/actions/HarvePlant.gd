extends "res://ai/actions/DoAction.gd"

func do_action(actor: Human, blackboard):
	actor.set_action(12)
	_rotate(actor, blackboard.get("ripe_plant"))
	result = RUNNING
	
func when_completed(actor: Human, blackboard):
	var ripe_plant: GardenBed = blackboard.get("ripe_plant")
	var plant = ripe_plant.harvest()
	blackboard.set("plant_type", plant.item_type)
	actor.add_item(plant)
	result = SUCCESS
