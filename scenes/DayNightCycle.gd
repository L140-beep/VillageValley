extends CanvasModulate

var time = WorldClock.time
const NIGHT_COLOR = Color("#1a198f")
const DAY_COLOR = Color("#ffffff")
const time_scale = 0.02


func _ready() -> void:
	Engine.time_scale = 2

func _physics_process(delta: float) -> void:
	time += delta * time_scale
	self.color = DAY_COLOR.linear_interpolate(NIGHT_COLOR, abs(sin(time)))
