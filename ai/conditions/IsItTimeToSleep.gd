extends ConditionLeaf

func tick(actor: Human, blackboard: Blackboard):
	if WorldClock.time > 21 or WorldClock.time < 5:
		return SUCCESS
	
	return FAILURE
