extends ConditionLeaf

func tick(actor, blackboard):
	var garden_beds = get_tree().get_nodes_in_group("FarmGardenBed")
	for garden_bed in garden_beds:
		if garden_bed.state == Types.GARDEN_BED_STATES.EMPTY:
			blackboard.set("empty_garden_bed", garden_bed)
			return SUCCESS
	return FAILURE
