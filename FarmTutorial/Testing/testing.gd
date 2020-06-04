extends Control

func _ready():
	pass # Replace with function body.

func _process(delta):
	$hour.text = str(Time.hour)
	$minutes.text = str(Time.minute)
	$seconds.text = str(Time.second)
	$day.text = str(Time.day)
	$month.text = str(Time.month)
	$year.text = str(Time.year)
	$spliter.text = str(Time.spliter)
	$season.text = str(Time.season)
	$minute_interval.text = str(Time.minute_interval)