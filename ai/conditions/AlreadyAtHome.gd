extends ConditionLeaf

func tick(actor: Human, blackboard):
	if actor.current_zone == Types.ZONES.HOME:
		return SUCCESS
	
	return FAILURE
