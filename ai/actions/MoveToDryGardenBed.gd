extends "res://ai/actions/Move.gd"

func setTarget(actor: Human, blackboard):
	target = blackboard.get("dry_garden_bed")
	actor.target_location = target.global_position
	actor.target_item = target
