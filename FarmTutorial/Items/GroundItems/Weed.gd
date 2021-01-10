extends StaticBody2D

# this helps determine that we only destroy weed once
var destroyed = false
onready var anim = $Anim

func _ready():
	anim.play("Idle")

func _on_Hurtbox_area_entered(area):
	if not destroyed:
		destroyed = true
		anim.play("Die")


func _on_Anim_animation_finished(anim_name):
	if anim_name == "Die":
		queue_free()
