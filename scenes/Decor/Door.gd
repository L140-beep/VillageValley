class_name Door
extends Node2D

onready var doorOpen = $Open
onready var doorClose = $Close
onready var area = $Area2D
onready var collision = $StaticBody2D/CollisionShape2D

func open() -> bool:
	doorOpen.visible = true
	doorClose.visible = false
	collision.set_deferred("disabled", true)
	
	return true

func close() -> bool:
	doorOpen.visible = false
	doorClose.visible = true
	collision.set_deferred("disabled", false)
	
	return true
