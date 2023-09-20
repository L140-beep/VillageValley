extends ConditionLeaf

func tick(actor: Human, blackboard):
	var bucket: Bucket = actor.get_item_without_deleting(Types.ITEMS.BUCKET)
	if bucket != null:
		if not bucket.is_empty():
			return SUCCESS
	
	return FAILURE
