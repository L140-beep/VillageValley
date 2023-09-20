extends ActionLeaf

func tick(actor: Human, blackboard):
	var bucket: Bucket = blackboard.get("closest_bucket")
	if actor.add_item(bucket):
		bucket.pick_up()
		print("after pick up", actor.items)
		return SUCCESS
	
	return FAILURE
