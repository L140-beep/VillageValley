extends "res://ai/actions/DoAction.gd"

func do_action(actor: Human, blackboard):
	actor.set_action(5)
	result = RUNNING
	_rotate(actor, blackboard.get("target_container"))

func when_completed(actor, blackboard):
	var container: VillageContainer = blackboard.get("target_container")
	print(container)
	if container.open():
		result = SUCCESS
		return
	
	result = FAILURE
	return
