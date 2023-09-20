extends BeehaveRoot

func _ready():
	# ensure _ready() has been finished everywhere else
	yield(get_tree().root, "ready")
