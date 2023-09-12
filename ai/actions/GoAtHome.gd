extends "res://ai/actions/Move.gd"

func setTarget(actor):
	target = actor.get_house().get_go_to_home_point()
	actor.target_location = target.global_position
