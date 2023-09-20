extends "res://ai/actions/DoAction.gd"

func when_completed(actor: Human, blackboard):
	var target_garden_bed: GardenBed = blackboard.get("empty_garden_bed")
	var _seed_type = blackboard.get("seed")
	if actor.pop_item(_seed_type):
		if target_garden_bed.to_plant(_seed_type):
			result = SUCCESS
		else:
			result = FAILURE

func do_action(actor: Human, blackboard):
	actor.set_action(10)
	_rotate(actor, blackboard.get("empty_garden_bed"))
