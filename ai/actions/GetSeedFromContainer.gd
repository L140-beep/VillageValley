extends ActionLeaf

func tick(actor: Human, blackboard):
	var container: VillageContainer = blackboard.get("target_container")
	var seed_type = blackboard.get("seed")
	var _seed = container.pop_item(seed_type)
	
	if _seed != null:
		if actor.add_item(_seed):
			return SUCCESS
	
	return FAILURE
