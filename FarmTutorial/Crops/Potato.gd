extends "Plant.gd"

# Nonshared Variables
export (Array) var phase_days = []



func _ready():
	Time.connect("new_day_start", self, "_on_new_day_start")
	check_dirt_status()
	check_plant_status(phase_days)
	
func initialize(crop_data):
	.initialize(crop_data)
	phase_days = crop_data.get("phase_days")
	
	$Anim.play(str(current_phase))
	
func _on_new_day_start():
	check_dirt_status()
	check_plant_status(phase_days)