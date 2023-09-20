extends ConditionLeaf

func tick(actor: Human, blackboard):
	if actor.can_do_interact(blackboard.get("empty_garden_bed")):
		return SUCCESS
	
	return FAILURE
