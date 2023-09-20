extends "res://ai/actions/Move.gd"

func setTarget(actor, blackboard):
	target = actor.get_house().get_bed().get_to_sleep_node()
	actor.target_location = target.global_position
