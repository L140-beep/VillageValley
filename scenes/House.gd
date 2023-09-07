class_name House
extends Node2D

var owners: Human
export (NodePath) var house_owner

onready var bed = $Bed

func get_bed() -> Bed:
	return bed

