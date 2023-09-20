extends ConditionLeaf

func tick(actor, blackboard):
	if actor.get_house().get_bed() != null:
		return SUCCESS
	return FAILURE
