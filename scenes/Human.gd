class_name Human
extends KinematicBody2D

signal target_reached
signal navigation_finished
signal door_detected

const MAX_STAMINA: int = 1_000_000
const DEFAULT_STAMINA_DRAIN: int = 23
var stamina: int = MAX_STAMINA
var stamina_drain_modificator: float = 1
export(bool) var show_stamina = true


export (String) var village_name
export (NodePath) var house

const AnimationStates = {
	IDLE = "Idle",
	RUN = "Run",
	SLEEP = "Sleep"
}

onready var nav_agent: NavigationAgent2D  = $NavigationAgent2D
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var nameLabel = $NameLabel
onready var sleepSprite = $Sleep
onready var otherSprite = $Sprite

export(Vector2) var target_location setget _set_target_location

export(float) var ACCELERATION = 540
export(float) var FRICTION = 770
export(float) var MAX_SPEED = 75

var state = AnimationStates.IDLE
var velocity = Vector2.ZERO
var direction = Vector2.ZERO

func get_house():
	return get_node(house)

func _ready() -> void:
	WorldClock.connect("time", self, "_time")
	nameLabel.text = village_name
	animationTree.active = true
	target_location = global_position
	nav_agent.set_target_location(target_location)

func _physics_process(delta: float) -> void:
	if target_location:
		var next_location = nav_agent.get_next_location()
		direction = (next_location - global_position).normalized()
		state = AnimationStates.RUN
		_prepare_move(direction, delta)
	elif state != AnimationStates.SLEEP:
		direction = Vector2.ZERO
		state = AnimationStates.IDLE
		_prepare_move(direction, delta)
	
	stamina = clamp(stamina - (stamina_drain_modificator * DEFAULT_STAMINA_DRAIN), 0, MAX_STAMINA)
	if show_stamina:
		print(stamina)
func _set_animation_direction(direction: Vector2) -> void:
		animationTree.set("parameters/Idle/blend_position", direction)
		animationTree.set("parameters/Run/blend_position", direction)

func _prepare_move(direction: Vector2, delta: float) -> void:
	_set_animation_direction(direction)
	if direction != Vector2.ZERO:
		animationState.travel(AnimationStates.RUN)
		
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
	if state != AnimationStates.SLEEP:
		var relation = ((self.velocity.y / MAX_SPEED) + (self.velocity.x / MAX_SPEED)) / 2
		stamina_drain_modificator = 1 + relation

func _on_NavigationAgent2D_velocity_computed(safe_velocity: Vector2) -> void:
	move(safe_velocity)

func _on_NavigationAgent2D_target_reached() -> void:
	emit_signal("target_reached")

func sleep():
	print(self)
	print("sleep")
	animationState.travel(AnimationStates.SLEEP)
	state = AnimationStates.SLEEP
	velocity = Vector2.ZERO
	stamina_drain_modificator = -2

func _on_NavigationAgent2D_navigation_finished() -> void:
	target_location = null
	emit_signal("navigation_finished")

func _on_DoorDetect_area_entered(area: Area2D) -> void:
	area.get_parent().open()
	emit_signal("door_detected", area.get_parent())

func _time(time):
	print(time)
		

func _on_DoorDetect_area_exited(door_area: Area2D) -> void:
	door_area.get_parent().close()
