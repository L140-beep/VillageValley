extends Node2D

signal time
signal new_day

var time = 5
export(int) var wait_time = 1
onready var timer = $Timer
var time_left
var day = 1

func _ready() -> void:
	$Timer.wait_time = wait_time
	time_left = $Timer.time_left
func _on_Timer_timeout() -> void:
	time = (time + 1) % 24
	if time == 0:
		day += 1
		print("emitted!!")
		emit_signal("new_day", day)
	emit_signal("time", time)
