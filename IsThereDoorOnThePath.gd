extends ConditionLeaf

func tick(actor, blackboard):
	if blackboard.get("door"):
		return SUCCESS
	return FAILURE
