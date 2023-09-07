extends ActionLeaf

var timer
export var wait_time = 1
var timeout: bool = false
var started: bool = false

func _ready() -> void:
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(wait_time)
	timer.connect("timeout", self, "_timer_callback")
	add_child(timer)

func tick(actor, blackboard):
	if not started:
		timer.start()
		started = true
	if timeout:
		timeout = false
		started = false
		return SUCCESS
	
	return RUNNING

func _timer_callback():
	timeout = true
