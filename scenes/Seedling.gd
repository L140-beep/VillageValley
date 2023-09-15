extends Node2D

const MAX_STAGE = 5

var tile_stage = 0

var ripe_days = 0
var dry_days = 0

enum GROW_STAGES { GROWING, RIPE, DEAD}
var dry = true
var state = GROW_STAGES.GROWING

onready var tile_pos = $Position2D
onready var dry_tile_map = $Dry
onready var wet_tile_map = $Wet
onready var dead_tile_map = $Dead

func _ready() -> void:
	WorldClock.connect("time", self, "_timeout")
	Engine.time_scale = 30

func water():
	dry_days = 0
	dry = false

func draw():
	if state != GROW_STAGES.DEAD:
		if dry:
			dry_tile_map.visible = true
			wet_tile_map.visible = false
			var tile: Vector2 = dry_tile_map.world_to_map(tile_pos.global_position)
			dry_tile_map.set_cellv(tile, tile_stage)
		else:
			dry_tile_map.visible = false
			wet_tile_map.visible = true
			var tile: Vector2 = wet_tile_map.world_to_map(tile_pos.global_position)
			wet_tile_map.set_cellv(tile, tile_stage)
	else:
			dead_tile_map.visible = true
			dry_tile_map.visible = false
			wet_tile_map.visible = false
			var tile: Vector2 = dead_tile_map.world_to_map(tile_pos.global_position)
			dead_tile_map.set_cellv(tile, tile_stage)

func _timeout(time):
	print(time)
	# Если день прошел
	if time == 0:
		#Проверяем, полили ли растение в прошлый день
		if dry:
			dry_days += 1
		if dry_days >= 3:
			state = GROW_STAGES.DEAD
		
		# Если не умерло - растем.
		if state != GROW_STAGES.DEAD:
			if tile_stage < 4:
				tile_stage += 1
			elif tile_stage == 4:
				state = GROW_STAGES.RIPE
				ripe_days += 1
				if ripe_days == 3:
					tile_stage = 5
					state = GROW_STAGES.DEAD

		dry = true
	draw()
