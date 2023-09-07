class_name Bed
extends Node2D


onready var to_sleep_pos = $ToSleepPos
onready var sleep_pos = $SleepPos

# Возвращает узел Position2D, в которой должен находится персонаж, чтобы лечь на кровать
func get_to_sleep_node():
	return to_sleep_pos

# Возвращает узел Position2D, в которой должен находится персонаж для того, чтобы лечь на кровать
func get_sleep_pos():
	return sleep_pos
