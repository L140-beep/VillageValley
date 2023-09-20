extends "res://ai/actions/DoAction.gd"

func when_completed(actor: Human, blackboard):
	actor.sit()
	result = SUCCESS

func do_action(actor: Human, blackboard):
	actor.set_action(0)
