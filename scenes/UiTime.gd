extends Control

onready var label = $Time
onready var dayLabel = $Day

func _ready() -> void:
	WorldClock.connect("time", self, "change_time")
	WorldClock.connect("new_day", self, "change_day")
	change_time(WorldClock.time)
	change_day(WorldClock.day)

func change_day(day):
	dayLabel.text = "Day: %s" % day
	print("heere")
func change_time(time):
	if time < 10:
		label.text = "0%s:00" % time
	else:
		label.text = "%s:00" % time
