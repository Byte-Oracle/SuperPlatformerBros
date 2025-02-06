extends CharacterBody2D

const speed = 200.0
const jump_velocity = -350.0
const jump_falling_multi = 1.25
const low_jump_falling_multi = 1.50
const coyote_time : int = 100

var facing_left : bool = false
var used_coyote_time : bool

var last_time_on_ground : float
var current_time : float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	GameManager.player = self

func _physics_process(delta):
	current_time = Time.get_ticks_msec()
	if is_on_floor():
		used_coyote_time = false
		last_time_on_ground = current_time

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	process_jumps(delta)
	set_facing()
	move_and_slide()

func process_jumps(delta):	
	if not is_on_floor() && current_time <= last_time_on_ground + coyote_time && not used_coyote_time && Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity
		used_coyote_time = true
		AudioStreamManager.play(AudioStreamManager.sfx.jump)
	elif is_on_floor() && Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity
		used_coyote_time = true 
		AudioStreamManager.play(AudioStreamManager.sfx.jump)
	
	if not is_on_floor():
		if Input.is_action_pressed("jump"):
			if velocity.y < 0:
				velocity.y += (gravity * jump_falling_multi) * delta
			else:
				velocity.y += gravity * delta
		else:
			velocity.y += (gravity * low_jump_falling_multi) * delta

func set_facing():
	if(velocity.x < 0):
		facing_left = true
	elif(velocity.x > 0):
		facing_left = false
