extends ConditionLeaf

func tick(actor, blackboard):
	for item_type in actor.items.keys():
		if item_type in Types.SEEDS:
			blackboard.set('seed', item_type)
			return SUCCESS
	
	return FAILURE
