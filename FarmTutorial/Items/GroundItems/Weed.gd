extends StaticBody2D

# this helps determine that we only destroy weed once
var destroyed = false
onready var anim = $Anim

# collectable instance
var coin = preload("res://Items/GroundItems/Coin.tscn")

func _ready():
	anim.play("Idle")
	
func destroy():
	if not destroyed:
		destroyed = true
		anim.play("Die")
		var coin_node = coin.instance()
		coin_node.position = position
		get_parent().add_child(coin_node)

func _on_Hurtbox_area_entered(area):
	destroy()


func _on_Anim_animation_finished(anim_name):
	if anim_name == "Die":
		queue_free()
