extends ConditionLeaf

func tick(actor, blackboard):
	var container: VillageContainer = blackboard.get("target_container")
	if container.is_open():
		return SUCCESS
	
	return FAILURE
