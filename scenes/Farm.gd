class_name Farm
extends Node2D


func get_seed_box():
	return get_tree().get_nodes_in_group("FarmSeedBox")

func get_fruit_box():
	return get_tree().get_nodes_in_group("FarmFruitBox")

func get_buckets():
	return get_tree().get_nodes_in_group("FarmBucket")

func get_pit():
	return get_tree().get_nodes_in_group("FarmPit")
