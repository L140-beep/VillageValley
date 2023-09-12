extends ConditionLeaf

func tick(actor, blackboard):
	if actor.get_house() != null:
		return SUCCESS
	
	return FAILURE
