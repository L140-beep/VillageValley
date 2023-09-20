extends ConditionLeaf

func tick(actor: Human, blackboard):
	if actor.can_do_interact(blackboard.get("closest_bucket")):
		return SUCCESS
	
	return FAILURE
