extends KinematicBody2D

var velocity = Vector2.ZERO
var max_speed = 48
var face_direction = Vector2(0, 1)

onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle Down")

func _physics_process(delta):
	var input_direction = Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
		)
	input_direction = input_direction.normalized()
	
	if input_direction != Vector2.ZERO:
		if input_direction.y == -1 and input_direction.x in [1, 0]:
			anim.play('Walk Up')
		elif input_direction.y == 1 and input_direction.x in [-1, 0]:
			anim.play('Walk Down')
		elif input_direction.x == 1 and input_direction.y in [0, 1]:
			anim.play('Walk Right')
		elif input_direction.x == -1 and input_direction.y in [0, -1]:
			anim.play("Walk Left")
		face_direction = input_direction
		velocity = input_direction * max_speed
	else:
		if face_direction.y == -1 and face_direction.x in [1, 0]:
			anim.play('Idle Up')
		elif face_direction.y == 1 and face_direction.x in [-1, 0]:
			anim.play("Idle Down")
		elif face_direction.x == 1 and face_direction.y in [0, 1]:
			anim.play('Idle Right')
		elif face_direction.x == -1 and face_direction.y in [0, -1]:
			anim.play("Idle Left")
		velocity = Vector2.ZERO
		
	move_and_slide(velocity, Vector2.ZERO)
