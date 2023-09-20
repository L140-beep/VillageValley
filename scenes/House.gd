class_name House
extends Node2D

var owners
export (NodePath) var house_owner
onready var chair = $Chair

onready var bed = $Bed
onready var go_to_home_point = $GoToHomePoint

func get_bed() -> Bed:
	return bed

func get_go_to_home_point():
	return go_to_home_point

func get_chair() -> Chair:
	return chair
