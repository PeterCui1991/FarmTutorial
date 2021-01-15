extends KinematicBody2D

var target_position = Vector2.ZERO
onready var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var res = rng.randi_range(-12,12)
	while res == 0:
		res = rng.randi_range(-12,12)
	var angle = 2.0 * PI / res
	var radius = 24
	var vect = Vector2(cos(angle), sin(angle)) * radius
	var offset = Vector2(8,8)
	target_position = global_position + offset + vect
	pop(offset, target_position)
	
func pop(offset, target):
	$Tween.interpolate_property(self, "global_position", global_position + offset, target, 0.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()
	$Anim.play("Bounce")


func _on_Tween_tween_completed(object, key):
	$Anim.play("Idle")
	$CollectingArea.monitoring = true # Only allow coin to be collected after bounce finished.
	

func _on_CollectingArea_body_entered(body):
	if body.name == "Player":
		print("Collect One Coin") # We can add more functions here to interact with Player Inventory or Money future
		queue_free()
