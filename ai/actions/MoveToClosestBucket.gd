extends "res://ai/actions/Move.gd"

func setTarget(actor: Human, blackboard):
	target = blackboard.get("closest_bucket")
	if target != null:
		actor.target_item = target
		actor.target_location = target.global_position
