extends ActionLeaf

func tick(actor, blackboard):
	var sleep_position = actor.get_house().get_bed().get_sleep_pos()
	actor.global_position = sleep_position.global_position
	
	return SUCCESS
