class_name Chair
extends Node2D

onready var sit_position = $sit_position
onready var to_sit_position = $to_sit_position

func get_sit_position():
	return sit_position

func get_to_sit_position():
	return to_sit_position
