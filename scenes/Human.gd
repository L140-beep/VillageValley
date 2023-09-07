class_name Human
extends KinematicBody2D

signal target_reached
signal navigation_finished

export (String) var village_name
export (NodePath) var house

const AnimationStates = {
	IDLE = "Idle",
	RUN = "Run"
}

onready var nav_agent: NavigationAgent2D  = $NavigationAgent2D
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var nameLabel = $NameLabel
export(Vector2) var target_location setget _set_target_location

export(float) var ACCELERATION = 540
export(float) var FRICTION = 770
export(float) var MAX_SPEED = 75

var state = AnimationStates.IDLE
var velocity = Vector2.ZERO
var direction = Vector2.ZERO

func get_house():
	print("here")
	print(house)
	return get_node(house)

func _ready() -> void:
	nameLabel.text = village_name
	animationTree.active = true
	target_location = global_position
	nav_agent.set_target_location(target_location)

func _physics_process(delta: float) -> void:
	if target_location:
		var next_location = nav_agent.get_next_location()
		direction = (next_location - global_position).normalized()
	else:
		direction = Vector2.ZERO
	
	_prepare_move(direction, delta)

func _set_animation_direction(direction: Vector2) -> void:
		animationTree.set("parameters/Idle/blend_position", direction)
		animationTree.set("parameters/Run/blend_position", direction)

func _prepare_move(direction: Vector2, delta: float) -> void:
	_set_animation_direction(direction)
	if direction != Vector2.ZERO:
		animationState.travel("Run")
		
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	nav_agent.set_velocity(velocity)
	#move(velocity)

func _set_target_location(new_target_location) -> void:
		target_location = new_target_location
		nav_agent.set_target_location(target_location)

func move(velocity: Vector2):
	self.velocity = move_and_slide(velocity)
	#move_and_collide()

func _on_NavigationAgent2D_velocity_computed(safe_velocity: Vector2) -> void:
	move(safe_velocity)

func _on_NavigationAgent2D_target_reached() -> void:
	emit_signal("target_reached")


func _on_NavigationAgent2D_navigation_finished() -> void:
	target_location = null
	emit_signal("navigation_finished")
