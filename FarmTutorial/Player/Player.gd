extends KinematicBody2D

var velocity = Vector2.ZERO
var max_speed = 48
var face_direction = Vector2(0, 1)

# State Machine
enum STATES {WALK, IDLE, ATTACK}
var state = 1 # 1 means IDLE, index of states, default

onready var anim = $AnimationPlayer

func _ready():
	_change_state(STATES.IDLE)
	
func _change_state(new_state):
	# What you want player to do when they switch to new state
	match new_state:
		STATES.IDLE:
			velocity = Vector2.ZERO
		STATES.WALK:
			pass
		STATES.ATTACK:
			pass
	state = new_state

func get_input_direction():
	var input_direction = Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
		)
	return input_direction
	
func _input(event):
	if Input.is_action_just_pressed("Action"):
		_change_state(STATES.ATTACK)
		return

func _physics_process(delta):
	match state:
		STATES.IDLE:
			# check if player has movement action when in IDLE
			var input_direction = get_input_direction()
			if input_direction:
				_change_state(STATES.WALK)
				return
				
			if face_direction.y == -1 and face_direction.x in [1, 0]:
				anim.play('Idle Up')
			elif face_direction.y == 1 and face_direction.x in [-1, 0]:
				anim.play("Idle Down")
			elif face_direction.x == 1 and face_direction.y in [0, 1]:
				anim.play('Idle Right')
			elif face_direction.x == -1 and face_direction.y in [0, -1]:
				anim.play("Idle Left")
			
		STATES.WALK:
			# check if player has no movement
			var input_direction = get_input_direction()
			if not input_direction:
				_change_state(STATES.IDLE)
				return
			if input_direction.y == -1 and input_direction.x in [1, 0]:
				anim.play('Walk Up')
			elif input_direction.y == 1 and input_direction.x in [-1, 0]:
				anim.play('Walk Down')
			elif input_direction.x == 1 and input_direction.y in [0, 1]:
				anim.play('Walk Right')
			elif input_direction.x == -1 and input_direction.y in [0, -1]:
				anim.play("Walk Left")
			input_direction = input_direction.normalized()
			face_direction = input_direction
			velocity = input_direction * max_speed
			
			move_and_slide(velocity, Vector2.ZERO)
			
		STATES.ATTACK:
			if face_direction.y == -1 and face_direction.x in [1, 0]:
				anim.play('Attack Up')
			elif face_direction.y == 1 and face_direction.x in [-1, 0]:
				anim.play("Attack Down")
			elif face_direction.x == 1 and face_direction.y in [0, 1]:
				anim.play('Attack Right')
			elif face_direction.x == -1 and face_direction.y in [0, -1]:
				anim.play("Attack Left")

func _on_AnimationPlayer_animation_finished(anim_name):
	if "Attack" in anim_name:
		_change_state(STATES.IDLE)
		return
