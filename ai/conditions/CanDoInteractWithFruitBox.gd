extends ConditionLeaf

func tick(actor: Human, blackboard):
	var box = actor.get_workplace().get_fruit_box()
	if box != []:
		if actor.can_do_interact(box[0]):
			blackboard.set("target_container", box[0])
			return SUCCESS
	
	return FAILURE
