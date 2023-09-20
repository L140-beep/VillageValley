extends "res://ai/actions/Move.gd"

func setTarget(actor, blackboard):
	target = blackboard.get("target_container")
	target = target.get_open_position()
	actor.target_location = target.global_position
