extends "res://ai/actions/Move.gd"

func setTarget(actor, blackboard):
	target = blackboard.get("empty_garden_bed")
	actor.target_location = target.global_position
	print(target)
	actor.target_item = target
	print(actor.target_item)
