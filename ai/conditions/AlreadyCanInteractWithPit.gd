extends ConditionLeaf

func tick(actor: Human, blackboard):
	var farm: Farm = actor.get_workplace()
	var pit = farm.get_pit()[0]
	blackboard.set("pit", pit)
	if actor.can_do_interact(pit):
		return SUCCESS
	
	return FAILURE
