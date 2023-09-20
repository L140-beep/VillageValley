extends CanvasModulate

onready var animationPlayer = $AnimationPlayer

func _process(delta: float) -> void:
	var current_time = (WorldClock.time * WorldClock.timer.wait_time) + WorldClock.timer.wait_time - WorldClock.timer.time_left
	animationPlayer.seek(current_time)
	animationPlayer.play("cycle")
