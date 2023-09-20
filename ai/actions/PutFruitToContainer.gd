extends "res://ai/actions/PutToContainer.gd"

func put(actor: Human, blackboard, container: VillageContainer):
	var food = actor.pop_item(blackboard.get("plant_type"))
	if container.put_item(food):
		return SUCCESS
	
	return FAILURE
