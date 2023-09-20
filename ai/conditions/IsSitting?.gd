extends ConditionLeaf

func tick(actor: Human, blackboard: Blackboard):
	if actor.state == actor.AnimationStates.SIT:
		return SUCCESS
	
	return FAILURE
