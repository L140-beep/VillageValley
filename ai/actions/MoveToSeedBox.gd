extends "res://ai/actions/Move.gd"

func setTarget(actor, blackboard):
	var seed_boxes = actor.get_workplace().get_seed_box()
	target = seed_boxes[0].get_open_position()
	blackboard.set("target_container", seed_boxes[0])
	actor.target_location = target.global_position
