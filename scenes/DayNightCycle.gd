extends CanvasModulate

var time = WorldClock.time
const NIGHT_COLOR = Color("#1a198f")
const DAY_COLOR = Color("#ffffff")
const DAY_SCALE = 0.05
const NIGHT_SCALE = 0.02
var time_scale = 0.05


func _ready() -> void:
	#Engine.time_scale = 2
	self.color = DAY_COLOR
	pass

func _physics_process(delta: float) -> void:
	time += delta * time_scale
	self.color = DAY_COLOR.linear_interpolate(NIGHT_COLOR, abs(sin(time)))
	if self.color == NIGHT_COLOR:
		time_scale = NIGHT_SCALE
	elif self.color == DAY_COLOR:
		time_scale = DAY_SCALE
		print(time_scale)
