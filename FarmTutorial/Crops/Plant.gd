extends StaticBody2D

var farm_map

export (int) var pk = 1
export (String) var object_name = ""
export (int) var current_phase = 0 # Seed Phase
export (int) var day_of_current_phase = 0
export (int) var crop_age = 0 
export (bool) var dead = false

func _ready():
	farm_map = get_parent()

func initialize(data):
	pk = data.get("pk")
	object_name = data.get("object_name")
	current_phase = data.get("current_phase")
	day_of_current_phase = data.get("day_of_current_phase")
	crop_age = data.get("crop_age")
	
	return data
	
func check_dirt_status():
	var dirt_pos = farm_map.world_to_map(position)
	var dirt_id = farm_map.get_cellv(dirt_pos)
	# Crop get cluttered
	if dirt_id == CONSTANTS.WET_DIRT_ID:
		crop_age += 1
		day_of_current_phase += 1
	else:
		pass # leave more space for extension.

func check_plant_status(phase_days):
	var required_days = phase_days[current_phase]
	if day_of_current_phase == required_days:
		current_phase += 1
		day_of_current_phase = 0
		
	var anim = str(current_phase)
	if current_phase == 0:
		$Shape.disabled = true
	elif current_phase == len(phase_days) - 1:
		$Shape.disabled = false
	else:
		$Shape.disabled = true
		
	$Anim.play(anim)
	