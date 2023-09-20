class_name Human
extends KinematicBody2D

signal target_reached
signal navigation_finished
signal complete_action

const MAX_STAMINA: int = 1_000_000
const DEFAULT_STAMINA_DRAIN: int = 23
var stamina: int = MAX_STAMINA
var stamina_drain_modificator: float = 1
export(bool) var show_stamina = true

export(int) var INVENTORY_CAPACITY = 10
var inventory_size = 0
var target_item = null
var items = {}

var can_interact = []

var free = 0
var do_action = false
export(float) var ACTION_SPEED = 0.08
var current_action_difficult = 0
var current_action_progress = 0

export (String) var village_name
export (NodePath) var house
export (NodePath) var workplace

var current_zone

const AnimationStates = {
	IDLE = "Idle",
	RUN = "Run",
	SLEEP = "Sleep",
	SIT = "Sit"
}

onready var nav_agent: NavigationAgent2D  = $NavigationAgent2D
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var nameLabel = $NameLabel
onready var sleepSprite = $Sleep
onready var otherSprite = $Sprite
onready var progressBar = $ProgressBar
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
	#Engine.time_scale = 2
	WorldClock.connect("time", self, "_time")
	nameLabel.text = village_name
	animationTree.active = true
	target_location = global_position
	nav_agent.set_target_location(target_location)
	
func _physics_process(delta: float) -> void:
	if do_action:
		progressBar.value += ACTION_SPEED
	else:
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

func set_action(difficult):
	progressBar.set_action(difficult)
	do_action = true

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

func move(velocity: Vector2) -> void:
	self.velocity = move_and_slide(velocity)
	if state != AnimationStates.SLEEP:
		var relation = ((self.velocity.y / MAX_SPEED) + (self.velocity.x / MAX_SPEED)) / 2
		stamina_drain_modificator = 1 + relation

func _on_NavigationAgent2D_velocity_computed(safe_velocity: Vector2) -> void:
	move(safe_velocity)

func _on_NavigationAgent2D_target_reached() -> void:
	emit_signal("target_reached")
	stop()

func stop():
	velocity = Vector2.ZERO
	target_location = null

func sleep():
	animationState.travel(AnimationStates.SLEEP)
	state = AnimationStates.SLEEP
	velocity = Vector2.ZERO
	stamina_drain_modificator = -2

func _on_NavigationAgent2D_navigation_finished() -> void:
	target_location = null
	stop()
	emit_signal("navigation_finished")

func _on_DoorDetect_area_entered(door_area: Area2D) -> void:
	door_area.get_parent().open()

func _time(time):
	print(time)
		

func sit():
	state = AnimationStates.SIT
	animationState.travel("SitDown")
	target_location = null
	stop()

func _on_DoorDetect_area_exited(door_area: Area2D) -> void:
	door_area.get_parent().close()

func pop_item(item_type) -> Item:
	print(Types.ITEMS.keys()[item_type])
	print(items)
	var item_arr = items.get(item_type)
	if item_arr:
		var item: Item = item_arr.back()
		inventory_size -= item.item_size
		item_arr.pop_back()
		if item_arr.empty():
			items.erase(item_type)
		
		return item
	
	return null

func get_workplace():
	return get_node(workplace)

func add_item(item: Item) -> bool:
	if inventory_size + item.item_size < INVENTORY_CAPACITY:
		if items.has(item.item_type):
			items.get(item.item_type).append(item)
		else:
			items[item.item_type] = [item]
		
		inventory_size += item.item_size
		return true
	return false

func _on_InteractArea_area_entered(area: Area2D) -> void:
	var item = area.get_parent()
	can_interact.append(area.get_parent())
	print(can_interact)
	if item == self.target_item:
		_on_NavigationAgent2D_target_reached()
		target_item = null

func can_do_interact(item) -> bool:
	for _item in self.can_interact:
		if _item == item:
			_on_NavigationAgent2D_target_reached()
			target_item = null
			return true
	
	return false

func _on_InteractArea_area_exited(area: Area2D) -> void:
	can_interact.erase(area.get_parent())
	print(can_interact)

func is_sleeping():
	return state == AnimationStates.SLEEP

func _on_ProgressBar_completed() -> void:
	do_action = false
	emit_signal("complete_action")


func _on_ZoneArea_area_entered(area: Area2D) -> void:
	var zone = area.get_parent()
	if zone is House:
		if zone == get_house():
			current_zone = Types.ZONES.HOME
		else:
			current_zone = Types.ZONES.HOUSE
	print(Types.ZONES.keys()[current_zone])

func get_item_without_deleting(item_type) -> Item:
	print(items)
	print(item_type)
	var item_arr: Array = items.get(item_type)
	if item_arr:
		var item: Item = item_arr.back()
		return item
	
	return null
