extends ConditionLeaf

func tick(actor: Human, blackboard):
	if actor.can_do_interact(blackboard.get("ripe_plant")):
		return SUCCESS
	
	return FAILURE
