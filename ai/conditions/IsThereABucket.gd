extends ConditionLeaf

func tick(actor: Human, blackboard):
	if actor.items.has(Types.ITEMS.BUCKET):
		return SUCCESS
	
	return FAILURE
