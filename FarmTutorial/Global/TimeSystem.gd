extends Node

const weekdays = ["Sun.", "Mon.", "Tue.", "Wed.", "Thur.", "Fri.", "Sat."]
const seasons = ["Spring", "Summer", "Fall", "Winter"]
const am_pm = ["AM", "PM"]
const minute_intervals = ["00", "10", "20", "30", "40", "50"] 

export (int) var second = 0
export (int) var minute = 0
export (int) var hour = 0
export (int) var day = 1
export (int) var month = 1
export (int) var year = 1
export (String) var weekday = "Sun."
export (int) var weekday_counter = 0
export (String) var season = "Spring"
export (String) var spliter = "AM"
export (String) var minute_interval = "00"

const default_time_speed = 10000
var day_processed = false

var time_speed = 80

signal new_day_start
signal refresh_tiles

func _ready():
	time_speed = default_time_speed
	
func _process(delta):
	if hour == 0 and day_processed == false and time_speed > 0:
		start_new_day()
		
	if hour == 2:
		emit_signal("refresh_tiles")
		
	if hour > 0:
		day_processed = false
		
	if time_speed > 0:
		second += int(floor(delta * time_speed))
		minute = (int(second) / 60) % 60
		hour = (int(second) / (60*60)) % 24
		spliter = am_pm[hour/12]
		minute_interval = minute_intervals[minute/10]

func start_new_day():
	second = 0
	minute = 0
	hour = 0
	day += 1
	day_processed = true
	emit_signal("new_day_start")
	# current month should end below:
	if day == 29:
		month += 1
		day = 1
		second = 0
		minute = 0
		hour = 0
		season = seasons[month-1]
		# for the last month of year, deal with year
		if month == 5:
			year += 1
			month = 1
			day = 1
			second = 0
			minute = 0
			hour = 0
			
	weekday_counter = int(day) % 7 - 1
	weekday = weekdays[weekday_counter]