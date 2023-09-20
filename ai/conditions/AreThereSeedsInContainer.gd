extends ConditionLeaf

func tick(actor, blackboard):
	var container: VillageContainer = blackboard.get("target_container")
	
	for _seed in Types.SEEDS:
		if container.has(_seed):
			blackboard.set("seed", _seed)
			return SUCCESS
	
	return FAILURE
