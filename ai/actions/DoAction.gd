extends ActionLeaf

var completed = false
var initialized = false
var result = RUNNING

func _rotate(actor: Human, object):
	actor._set_animation_direction(actor.global_position.direction_to(object.global_position))
	
func _initialize(actor):
	initialized = true
	actor.connect("complete_action", self, "_complete_action")

func when_completed(actor, blackboard):
	pass

func do_action(actor, blackboard):
	pass

func _reset():
	completed = false

func tick(actor: Human, blackboard):
	result = RUNNING
	if not initialized:
		_initialize(actor)
		
	if not actor.do_action and not completed:
		do_action(actor, blackboard)
	
	if completed:
		_reset()
		when_completed(actor, blackboard)
		
	return result

func _complete_action():
	completed = true
