extends Node2D

signal time

var time = 0
export(int) var wait_time = 1

func _ready() -> void:
	$Timer.wait_time = wait_time

func _on_Timer_timeout() -> void:
	time = (time + 1) % 24
	emit_signal("time", time)
