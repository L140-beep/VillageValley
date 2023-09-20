extends Control

signal completed
onready var value = $TextureProgress.value setget _value_changed
onready var max_value = $TextureProgress.max_value

func set_action(difficult):
	max_value = difficult
	$TextureProgress.max_value = max_value
	value = 0
	visible = true

func _value_changed(new_value):
	value = new_value
	$TextureProgress.value = value
	if value >= max_value:
		emit_signal("completed")
		value = 0 
		$TextureProgress.value = value
		visible = false
