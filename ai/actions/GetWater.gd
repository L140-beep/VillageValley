extends "res://ai/actions/DoAction.gd"

func do_action(actor: Human, blackboard):
	print("setted")
	actor.set_action(13)
	_rotate(actor, blackboard.get("pit"))
	result = RUNNING

func when_completed(actor: Human, blackboard):
	print('herre')
	var bucket: Bucket = actor.get_item_without_deleting(Types.ITEMS.BUCKET)
	var pit: Pit = blackboard.get("pit")
	pit.getWater(bucket)
	print(bucket.get_volume())
	result = SUCCESS
