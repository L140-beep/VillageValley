class_name Bucket
extends Item

export(int) var max_volume = 100
var current_volume = 0
onready var with_water = $BucketWIthWater
onready var empty = $Empty
onready var area = $Area2D/CollisionShape2D
var picked_up = false
var group
func _ready() -> void:
	with_water.visible = false
	empty.visible = true
	group = get_groups()[0]

func is_empty():
	print(current_volume)
	print(current_volume == 0)
	return current_volume == 0

func pick_up():
	with_water.visible = false
	empty.visible = false
	area.set_deferred("disabled", false)
	remove_from_group(group)
	picked_up = true

func get_volume():
	return current_volume

func set_volume(delta_volume):
	current_volume = clamp(current_volume + delta_volume, 0, 100)
	if not picked_up:
		if current_volume > 0:
			with_water.visible = true
			empty.visible = false
		else:
			with_water.visible = true
			empty.visible = false
		
		

