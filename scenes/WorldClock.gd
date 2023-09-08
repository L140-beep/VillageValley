extends Node2D

signal time

var time = 0

func _on_Timer_timeout() -> void:
	time = (time + 1) % 24
	emit_signal("time", time)
