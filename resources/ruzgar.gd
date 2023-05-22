extends CharacterBody3D

var is_running = true
@export var base_speed = 0.25
@export var jump_force = 9.0
@export var gravity = 9.0
@export var left_lane = -9.0
@export var lane_size = 10.0
@export var lane = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_lane_position()

func set_lane_position():
	global_position.z = lane * lane_size + left_lane

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("game_left"):
		lane -= 1
		set_lane_position()
	if Input.is_action_just_pressed("game_right"):
		lane += 1
		set_lane_position()
	
func _physics_process(delta):
	var newVel = Vector3(base_speed, gravity, 0)
	if Input.is_action_pressed("game_jump") and is_on_floor():
		velocity.y = jump_force
		newVel.y += jump_force
		
	velocity = velocity.lerp(newVel, 0.1)
		
	print(velocity)
	if is_running:
		move_and_slide()
	global_position.y = max(global_position.y, -2)
