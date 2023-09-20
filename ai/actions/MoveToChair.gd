extends "res://ai/actions/Move.gd"

func setTarget(actor: Human, blackboard: Blackboard):
	var chair: Chair = actor.get_house().get_chair()
	target = chair
	actor.target_location = chair.get_to_sit_position().global_position
