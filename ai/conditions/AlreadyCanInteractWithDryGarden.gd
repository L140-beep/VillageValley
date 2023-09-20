extends ConditionLeaf

func tick(actor: Human, blackboard):
	if actor.can_do_interact(blackboard.get("dry_garden_bed")):
		return SUCCESS
	
	return FAILURE
