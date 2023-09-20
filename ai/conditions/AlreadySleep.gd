extends ConditionLeaf

func tick(actor: Human, blackboard):
	if actor.is_sleeping():
		return SUCCESS
	
	return FAILURE
