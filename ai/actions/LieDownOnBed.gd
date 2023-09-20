extends "res://ai/actions/DoAction.gd"

func when_completed(actor, blackboard):
	var sleep_position = actor.get_house().get_bed().get_sleep_pos()
	actor.global_position = sleep_position.global_position
	result = SUCCESS

func do_action(actor: Human, blackboard):
	actor.set_action(5)
	_rotate(actor, actor.get_house().get_bed().get_sleep_pos())
