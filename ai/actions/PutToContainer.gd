extends "res://ai/actions/DoAction.gd"

func put(actor, blackboard, container: VillageContainer):
	pass

func when_completed(actor: Human, blackboard):
	var container = blackboard.get("target_container")
	if put(actor, blackboard, container):
		return SUCCESS
	
	return FAILURE

func do_action(actor: Human, blackboard):
	actor.set_action(5)
