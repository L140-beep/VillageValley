extends ConditionLeaf

func tick(actor: Human, blackboard):
	var seed_boxes = get_tree().get_nodes_in_group("FarmGardenBed")
	
	for seed_box in seed_boxes:
		if seed_box.state != Types.GARDEN_BED_STATES.EMPTY:
			if seed_box.plant.state == seed_box.plant.GROW_STAGES.RIPE:
				blackboard.set("ripe_plant", seed_box)
				print("here")
				print(seed_box)
				return SUCCESS
	
	return FAILURE
