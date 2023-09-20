class_name Item
extends Node

export(Types.ITEMS) var item_type
export(int) var item_size = 1

func pick_up():
	queue_free()
