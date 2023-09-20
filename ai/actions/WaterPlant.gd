extends "res://ai/actions/DoAction.gd"

func do_action(actor: Human, blackboard):
	actor.set_action(10)
	_rotate(actor, blackboard.get("dry_garden_bed"))
	result = RUNNING
	
func when_completed(actor: Human, blackboard):
	var dry_garden_bed: GardenBed = blackboard.get("dry_garden_bed")
	var bucket: Bucket = actor.get_item_without_deleting(Types.ITEMS.BUCKET)
	bucket.set_volume(-20)
	dry_garden_bed.water()
	result = SUCCESS
