extends "res://ai/actions/Move.gd"

func setTarget(actor: Human, blackboard):
	target = blackboard.get("pit")
	actor.target_location = target.global_position
	actor.target_item = target
