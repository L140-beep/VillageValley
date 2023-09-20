extends ActionLeaf

var target_reached = false
var navigation_finished = false
var initialized = false
var target = null


func init(actor):
	target = null
	actor.connect("target_reached", self, "_target_reached")
	actor.connect("navigation_finished", self, "_navigation_finished")
	self.initialized = true

func _reset(actor):
	actor.disconnect("target_reached", self, "_target_reached")
	actor.disconnect("navigation_finished", self, "_navigation_finished")
	target_reached = false
	navigation_finished = false
	initialized = false
	actor = null

func setTarget(actor, blackboard):
	pass

func tick(actor, blackboard):
	if not initialized:
		init(actor)
	if target_reached:
		_reset(actor)
		return SUCCESS
	if navigation_finished and not target_reached:
		_reset(actor)
		return FAILURE
	
	if target == null:
		setTarget(actor, blackboard)
	return RUNNING

func _target_reached():
	print("reached!")
	target_reached = true


func _navigation_finished():
	print("navigation finished!")
	navigation_finished = true
