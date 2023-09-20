class_name Plant
extends Node2D

# Количество стадий роста, 5 стадий - 5 тайлов
const MAX_STAGE = 1

# Количество дней, которое растение может продержаться без воды прежде чем начать сохнуть
export(int) var DAYS_TO_DRY = 1
# Количество дней, которое необходимо растению для перехода в другую стадию роста
export(int) var DAYS_TO_GROW = 1

var to_grow_days = 0
var to_dry_days = 0

var tile_stage = 0

var ripe_days = 0
var dry_days = 0

enum GROW_STAGES { GROWING, RIPE, DEAD}
var dry = true
var state = GROW_STAGES.GROWING

const beetFood = preload("res://scenes/BeetFood.tscn")

onready var tile_pos = $Position2D
onready var dry_tile_map = $Dry
onready var wet_tile_map = $Wet
onready var dead_tile_map = $Dead

func _ready() -> void:
	WorldClock.connect("time", self, "_timeout")
	#Engine.time_scale = 30

func water():
	dry_days = 0
	to_dry_days = 0
	dry = false
	draw()

func draw():
	if state != GROW_STAGES.DEAD:
		if dry:
			dry_tile_map.visible = true
			wet_tile_map.visible = false
			dead_tile_map.visible = false
			var tile: Vector2 = dry_tile_map.world_to_map(tile_pos.position)
			#var tile = dry_tile_map.to_global(tile_pos.global_position)
			dry_tile_map.set_cellv(tile, tile_stage)
		else:
			wet_tile_map.visible = true
			dry_tile_map.visible = false
			dead_tile_map.visible = false
			var tile: Vector2 = wet_tile_map.world_to_map(tile_pos.position)
			#var tile = wet_tile_map.to_global(tile_pos.global_position)
			wet_tile_map.set_cellv(tile, tile_stage)
	else:
			dead_tile_map.visible = true
			dry_tile_map.visible = false
			wet_tile_map.visible = false
			var tile: Vector2 = dead_tile_map.world_to_map(tile_pos.position)
			# var tile = dead_tile_map.to_global(tile_pos.global_position)
			dead_tile_map.set_cellv(tile, tile_stage)

#func _physics_process(delta: float) -> void:
#	draw()

func harvest() -> Food:
	var food = beetFood.instance()
	return food

func _timeout(time):
	print(time)
	# Если день прошел
	if time == 0:
		#Проверяем, полили ли растение в прошлый день
		to_dry_days += 1
		if dry:
			dry_days += 1
		else:
			to_grow_days += 1
		if dry_days >= 3:
			state = GROW_STAGES.DEAD
		
		# Если не умерло - растем.
		if state != GROW_STAGES.DEAD:
			if tile_stage < MAX_STAGE - 1 and not dry and to_grow_days >= DAYS_TO_GROW:
				tile_stage += 1
				to_grow_days = 0
			elif tile_stage == MAX_STAGE - 1:
				state = GROW_STAGES.RIPE
				ripe_days += 1
				if ripe_days == 3:
					tile_stage = 5
					state = GROW_STAGES.DEAD
		
		if to_dry_days >= DAYS_TO_DRY:
			dry = true
	draw()
	print(GROW_STAGES.keys()[state])
