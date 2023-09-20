extends ConditionLeaf

func tick(actor: Human, blackboard):
	var buckets = actor.get_workplace().get_buckets()
	var min_distance = 999999
	var closest_bucket = null
	for bucket in buckets:
		if actor.global_position.distance_to(bucket.global_position) < min_distance:
			closest_bucket = bucket
	
	if closest_bucket != null:
		blackboard.set("closest_bucket", closest_bucket)
		return SUCCESS
	
	return FAILURE
